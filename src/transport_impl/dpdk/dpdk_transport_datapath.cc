#ifdef ERPC_DPDK

#include "dpdk_transport.h"
#include "util/huge_alloc.h"
#include <sys/time.h>
#include "rpc.h"

namespace erpc {
static void format_pkthdr(pkthdr_t *pkthdr,
                          const Transport::tx_burst_item_t &item,
                          const size_t pkt_size) {
  // We can do an 8-byte aligned memcpy as the 2-byte UDP csum is already 0
  static constexpr size_t kHdrCopySz = kInetHdrsTotSize - 2;
  static_assert(kHdrCopySz == 40, "");
  memcpy(&pkthdr->headroom_[0], item.routing_info_, kHdrCopySz);

  if (kTesting && item.drop_) {
    // XXX: Can this cause performance problems?
    eth_hdr_t *eth_hdr = pkthdr->get_eth_hdr();
    memset(&eth_hdr->dst_mac_, 0, sizeof(eth_hdr->dst_mac_));
  }

  // On most bare-metal clusters, a zero IP checksum works fine. But on Azure
  // VMs we need a valid checksum.
  ipv4_hdr_t *ipv4_hdr = pkthdr->get_ipv4_hdr();
  ipv4_hdr->tot_len_ = htons(pkt_size - sizeof(eth_hdr_t));
  ipv4_hdr->check_ = get_ipv4_checksum(ipv4_hdr);

  udp_hdr_t *udp_hdr = pkthdr->get_udp_hdr();
  assert(udp_hdr->check_ == 0);
  udp_hdr->len_ = htons(pkt_size - sizeof(eth_hdr_t) - sizeof(ipv4_hdr_t));
}

void DpdkTransport::tx_burst(const tx_burst_item_t *tx_burst_arr,
                             size_t num_pkts) {

  rte_mbuf *tx_mbufs[kPostlist];
  #ifdef lqj_debug
  int thread_num = -1;
  #endif
  for (size_t i = 0; i < num_pkts; i++) {
    const tx_burst_item_t &item = tx_burst_arr[i];
    const MsgBuffer *msg_buffer = item.msg_buffer_;
    #ifdef ZeroCopyTX
      erpc::rt_assert(item.pkt_idx_ == 0 && msg_buffer->num_pkts_ == 1, "ZeroCopyTX but not a single-packet req");
      tx_mbufs[i] = reinterpret_cast<rte_mbuf*>(msg_buffer->tx_mbuf);
    #else
      tx_mbufs[i] = rte_pktmbuf_alloc(mempool_);
    #endif

    assert(tx_mbufs[i] != nullptr);

    pkthdr_t *pkthdr;
    if (item.pkt_idx_ == 0) {
      // This is the first packet, so we need only one seg. This can be CR/RFR.
      pkthdr = msg_buffer->get_pkthdr_0();
      const size_t pkt_size = msg_buffer->get_pkt_size<kMaxDataPerPkt>(0);
      format_pkthdr(pkthdr, item, pkt_size);

      tx_mbufs[i]->nb_segs = 1;
      tx_mbufs[i]->pkt_len = pkt_size;
      tx_mbufs[i]->data_len = pkt_size;
      #ifdef ZeroCopyTX
      // memcpy(rte_pktmbuf_mtod(tx_mbufs[i], uint8_t *), pkthdr, pkt_size);
      #else
      memcpy(rte_pktmbuf_mtod(tx_mbufs[i], uint8_t *), pkthdr, pkt_size);
      #endif
    } else {
      // This is not the first packet, we also need only one seg.
      pkthdr = msg_buffer->get_pkthdr_n(item.pkt_idx_);
      const size_t pkt_size =
          msg_buffer->get_pkt_size<kMaxDataPerPkt>(item.pkt_idx_);
      format_pkthdr(pkthdr, item, pkt_size);

      tx_mbufs[i]->nb_segs = 1;
      tx_mbufs[i]->pkt_len = pkt_size;
      tx_mbufs[i]->data_len = pkt_size;
      memcpy(rte_pktmbuf_mtod(tx_mbufs[i], uint8_t *), pkthdr,
               sizeof(pkthdr_t));
      memcpy(rte_pktmbuf_mtod_offset(tx_mbufs[i], uint8_t *, sizeof(pkthdr_t)),
               &msg_buffer->buf_[item.pkt_idx_ * kMaxDataPerPkt],
               pkt_size - sizeof(pkthdr_t));
    }
    // printf("data_off: %d pkt_len: %d  data_len: %d\n", tx_mbufs[i]->data_off, tx_mbufs[i]->pkt_len, tx_mbufs[i]->data_len);
    // printf("rte_mbuf header: %s\n", frame_header_to_string(reinterpret_cast<uint8_t*>(tx_mbufs[i]->buf_addr)+tx_mbufs[i]->data_off).c_str());
    // uint8_t *data = reinterpret_cast<uint8_t*>(tx_mbufs[i]->buf_addr) + tx_mbufs[i]->data_off + sizeof(pkthdr_t);
    // printf("rte_mbuf data: %d%d%d%d\n",*data, data[1], data[2], data[3]);

    ERPC_TRACE(
        "Transport: TX (idx = %zu, drop = %u). pkthdr = %s. Frame  = %s.\n", i,
        item.drop_, pkthdr->to_string().c_str(),
        frame_header_to_string(&pkthdr->headroom_[0]).c_str());
    
    #ifdef lqj_debug
    if(thread_num == -1){
      auto* eth_hdr = reinterpret_cast<const eth_hdr_t*>(&pkthdr->headroom_[0]);
      auto* ipv4_hdr = reinterpret_cast<const ipv4_hdr_t*>(&eth_hdr[1]);
      auto* udp_hdr = reinterpret_cast<const udp_hdr_t*>(&ipv4_hdr[1]);
      thread_num = ntohs(udp_hdr->dst_port_) - 10000;
    }
    #endif
  }

  #ifdef lqj_debug
    struct timeval cur_time;
    gettimeofday(&cur_time, NULL);
    long long send_finish_time = (cur_time.tv_sec * 1000000.0 + cur_time.tv_usec);
    printf("%d erpc send one round time: %lld\n", thread_num, send_finish_time % 10000);
  #endif
  
  size_t nb_tx_new = rte_eth_tx_burst(phy_port_, qp_id_, tx_mbufs, num_pkts);
  if (unlikely(nb_tx_new != num_pkts)) {
    #ifdef lqj_debug
      printf("nb_tx_new != num_pkts\n");
    #endif
    size_t retry_count = 0;
    while (nb_tx_new != num_pkts) {
      nb_tx_new += rte_eth_tx_burst(phy_port_, qp_id_, &tx_mbufs[nb_tx_new],
                                    num_pkts - nb_tx_new);
      retry_count++;
      if (unlikely(retry_count == 1000000000)) {
        ERPC_WARN("Rpc %u stuck in rte_eth_tx_burst", rpc_id_);
        retry_count = 0;
      }
    }
  }
  #ifdef lqj_debug
    // struct timeval cur_time;
    gettimeofday(&cur_time, NULL);
    send_finish_time = (cur_time.tv_sec * 1000000.0 + cur_time.tv_usec);
    printf("%d dpdk send one round time: %lld\n",thread_num, send_finish_time % 10000);
    printf("%d send packets: %lu\n",thread_num, num_pkts);
  #endif
}

void DpdkTransport::tx_flush() {
  // Nothing to do because we don't zero-copy for now
  testing_.tx_flush_count_++;
  return;
}

void DpdkTransport::drain_rx_queue() {
  struct rte_mbuf *rx_pkts[kRxBatchSize];

  while (true) {
    size_t nb_rx_new =
        rte_eth_rx_burst(phy_port_, qp_id_, rx_pkts, kRxBatchSize);
    if (nb_rx_new == 0) return;
    for (size_t i = 0; i < nb_rx_new; i++) rte_pktmbuf_free(rx_pkts[i]);
  }
}

size_t DpdkTransport::rx_burst() {
  struct rte_mbuf *rx_pkts[kRxBatchSize];
  size_t nb_rx_new = rte_eth_rx_burst(phy_port_, qp_id_, rx_pkts, kRxBatchSize);

  for (size_t i = 0; i < nb_rx_new; i++) {
    rx_ring_[rx_ring_head_] = rte_pktmbuf_mtod(rx_pkts[i], uint8_t *);
    assert(dpdk_dtom(rx_ring_[rx_ring_head_]) == rx_pkts[i]);

    auto *pkthdr = reinterpret_cast<pkthdr_t *>(rx_ring_[rx_ring_head_]);
    
    // uint8_t *data = rx_ring_[rx_ring_head_] + sizeof(pkthdr_t);
    // printf("rx_burst1: data_off = %d, rx_ring_head_ = %ld\n", rx_pkts[i]->data_off, rx_ring_head_);
    // printf("rx_burst2: RTE_PKTMBUF_HEADROOM = %d, sizeof(rte_mbuf) = %ld\n", RTE_PKTMBUF_HEADROOM, sizeof(rte_mbuf));
    // printf("rx_burst3: rx_pkts[i] = %lld,  rx_ring_[rx_ring_head_] = %lld\n",reinterpret_cast<long long>(rx_pkts[i]), reinterpret_cast<long long>(rx_ring_[rx_ring_head_]));
    // printf("rx_burst4: data = %d %d %d\n", data[0],data[1],data[20]);
    
    _unused(pkthdr);
    ERPC_TRACE("Transport: RX pkthdr = %s. Frame = %s.\n",
               pkthdr->to_string().c_str(),
               frame_header_to_string(&pkthdr->headroom_[0]).c_str());

#if DEBUG
    if (unlikely(ntohl(pkthdr->get_ipv4_hdr()->dst_ip) != resolve_.ipv4_addr ||
                 ntohs(pkthdr->get_udp_hdr()->dst_port) != rx_flow_udp_port_)) {
      ERPC_ERROR("Invalid packet. Pkt: %u %s %s. Me: %u %s %s\n",
                 ntohs(pkthdr->get_udp_hdr()->dst_port_),
                 ipv4_to_string(pkthdr->get_ipv4_hdr()->dst_ip_).c_str(),
                 mac_to_string(pkthdr->get_eth_hdr()->dst_mac_).c_str(),
                 rx_flow_udp_port_, ipv4_to_string(resolve_.ipv4_addr_).c_str(),
                 mac_to_string(resolve_.mac_addr_).c_str());
      exit(-1);
    }
#endif

    rx_ring_head_ = (rx_ring_head_ + 1) % kNumRxRingEntries;
  }

  return nb_rx_new;
}

void DpdkTransport::post_recvs(size_t num_recvs) {
  for (size_t i = 0; i < num_recvs; i++) {
    auto *mbuf = dpdk_dtom(rx_ring_[rx_ring_tail_]);
#if DEBUG
    rte_mbuf_sanity_check(mbuf, true /* is_header */);
#endif
    rte_pktmbuf_free(mbuf);

    rx_ring_tail_ = (rx_ring_tail_ + 1) % kNumRxRingEntries;
  }
}

}  // namespace erpc

#endif
