/**
 * @file large_rpc_tput.cc
 *
 * @brief Benchmark to measure large RPC throughput. Each thread measures its
 * RX and TX bandwidth.
 *
 * Each thread creates at most one session. Session connectivity is controlled
 * by the "profile" flag. The available profiles are:
 *   o incast: Incast
 *   o victim: With N processes {0, ..., N - 1}, where N >= 3:
 *     o Process 0 and process (N - 1) do not send requests
 *     o All threads on processes 1 through (N - 2) incast to process 0
 *     o Thread T - 1 on processes (N - 2) sends requests to process (N - 1)
 */

#include "large_rpc_tput.h"
#include <signal.h>
#include <cstring>
#include "profile_incast.h"
#include "profile_victim.h"
#include "util/autorun_helpers.h"

static constexpr size_t kAppEvLoopMs = 1000;  // Duration of event loop
static constexpr bool kAppVerbose = false;

// Experiment control flags
static constexpr bool kAppClientMemsetReq = false;   // Fill entire request
static constexpr bool kAppServerMemsetResp = true;  // Fill entire response
static constexpr bool kAppClientCheckResp = false;   // Check entire response

// Profile-specifc session connection function
std::function<void(AppContext *)> connect_sessions_func = nullptr;

size_t transmission = 1000000000;//1GB
double small_prop = 0;
double large_prop = 1-small_prop;
size_t counter = 0;
size_t distribution_size = 10000;
std::vector<int> distrib;

void app_cont_func(void *, void *);  // Forward declaration

// Send a request using this MsgBuffer
void send_req(AppContext *c, size_t msgbuf_idx) {
  erpc::MsgBuffer &req_msgbuf = c->req_msgbuf[msgbuf_idx];
  #ifdef run_flow_distribution
  int random = distrib[(++counter)%distribution_size];
  size_t cur_size = random ? FLAGS_large_req_size : FLAGS_small_req_size;
  c->rpc_->resize_msg_buffer(&req_msgbuf, cur_size);
  #else 
  size_t cur_size = FLAGS_req_size;
  #endif

  size_t req_type;
  if (c->fastrand_.next_u32() % 100 < FLAGS_bgthread_req_percent) {
    // handled by background thread
    req_type = kAppReqType_Bg;
  } else {
    // handled by foreground thread
    req_type = kAppReqType_Fg;  // Generate a point request
  }

  if (kAppVerbose) {
    printf("large_rpc_tput: Thread %zu sending request using msgbuf_idx %zu.\n",
           c->thread_id_, msgbuf_idx);
  }

  c->req_ts[msgbuf_idx] = erpc::rdtsc();
  c->rpc_->enqueue_request(c->session_num_vec_[0], req_type, &req_msgbuf,
                           &c->resp_msgbuf[msgbuf_idx], app_cont_func,
                           reinterpret_cast<void *>(msgbuf_idx));

  c->stat_tx_bytes_tot += cur_size;
}

void req_handler(erpc::ReqHandle *req_handle, void *_context) {
  auto *c = static_cast<AppContext *>(_context);
  const erpc::MsgBuffer *req_msgbuf = req_handle->get_req_msgbuf();
  #ifdef KeepSend
  size_t cur_size = req_msgbuf->get_data_size();
  c->stat_rx_bytes_tot += cur_size;
  #else

  uint8_t resp_byte = req_msgbuf->buf_[0];

  // Use dynamic response
  erpc::MsgBuffer &resp_msgbuf = req_handle->dyn_resp_msgbuf_;
  resp_msgbuf = c->rpc_->alloc_msg_buffer_or_die(FLAGS_resp_size);

  #ifdef DPDK
  #ifdef ZeroCopyTX
  msgbuf_to_rte_mbuf(c, resp_msgbuf);
  #endif
  #endif

  // Touch the response
  if (kAppServerMemsetResp) {
    memset(resp_msgbuf.buf_, resp_byte, FLAGS_resp_size);
  } else {
    resp_msgbuf.buf_[0] = resp_byte;
  }

  c->stat_rx_bytes_tot += FLAGS_req_size;
  c->stat_tx_bytes_tot += FLAGS_resp_size;

  c->rpc_->enqueue_response(req_handle, &resp_msgbuf);
  #endif
}

void app_cont_func(void *_context, void *_tag) {
  auto *c = static_cast<AppContext *>(_context);
  auto msgbuf_idx = reinterpret_cast<size_t>(_tag);
  #ifndef KeepSend
  const erpc::MsgBuffer &resp_msgbuf = c->resp_msgbuf[msgbuf_idx];
  if (kAppVerbose) {
    printf("large_rpc_tput: Received response for msgbuf %zu.\n", msgbuf_idx);
  }

  // Measure latency. 1 us granularity is sufficient for large RPC latency.
  double usec = erpc::to_usec(erpc::rdtsc() - c->req_ts[msgbuf_idx],
                              c->rpc_->get_freq_ghz());
  c->lat_vec.push_back(usec);

  // Check the response
  erpc::rt_assert(resp_msgbuf.get_data_size() == FLAGS_resp_size,
                  "Invalid response size");

  if (kAppClientCheckResp) {
    bool match = true;
    // Check all response cachelines (checking every byte is slow)
    for (size_t i = 0; i < FLAGS_resp_size; i += 64) {
      if (resp_msgbuf.buf_[i] != kAppDataByte) match = false;
    }
    erpc::rt_assert(match, "Invalid resp data");
  } else {
    erpc::rt_assert(resp_msgbuf.buf_[0] == kAppDataByte, "Invalid resp data");
  }

  c->stat_rx_bytes_tot += FLAGS_resp_size;
  #endif

  #ifdef DPDK
  #ifdef ZeroCopyTX
  msgbuf_to_rte_mbuf(c, c->req_msgbuf[msgbuf_idx]);
  #endif
  #endif

  // Create a new request clocking this response, and put in request queue
  if (kAppClientMemsetReq) {
    memset(c->req_msgbuf[msgbuf_idx].buf_, kAppDataByte, FLAGS_req_size);
  } else {
    c->req_msgbuf[msgbuf_idx].buf_[0] = kAppDataByte;
  }

  send_req(c, msgbuf_idx);
}
#ifdef run_flow_distribution
void generate_distribution(){
  distrib.clear();
  std::discrete_distribution<size_t> d{small_prop*FLAGS_large_req_size, large_prop*FLAGS_small_req_size}; // probability
  std::random_device rd;
  std::default_random_engine rng {rd()};
  for (size_t i = 0; i < distribution_size; i++){
    int random = d(rng);
    distrib.push_back(random);
  }
}
#endif
// The function executed by each thread in the cluster
void thread_func(size_t thread_id, app_stats_t *app_stats, erpc::Nexus *nexus) {
  AppContext c;
  c.thread_id_ = thread_id;
  c.app_stats = app_stats;
  if (thread_id == 0)
    c.tmp_stat_ = new TmpStat(app_stats_t::get_template_str());

  std::vector<size_t> port_vec = flags_get_numa_ports(FLAGS_numa_node);
  erpc::rt_assert(port_vec.size() > 0);
  uint8_t phy_port = port_vec.at(thread_id % port_vec.size());

  erpc::Rpc<erpc::CTransport> rpc(nexus, static_cast<void *>(&c),
                                  static_cast<uint8_t>(thread_id),
                                  basic_sm_handler, phy_port);
  rpc.retry_connect_on_invalid_rpc_id_ = true;
  if (erpc::kTesting) rpc.fault_inject_set_pkt_drop_prob_st(FLAGS_drop_prob);

  c.rpc_ = &rpc;

  // Create the session. Some threads may not create any sessions, and therefore
  // not run the event loop required for other threads to connect them. This
  // is OK because all threads will run the event loop below.
  connect_sessions_func(&c);

  if (c.session_num_vec_.size() > 0) {
    printf("large_rpc_tput: Thread %zu: All sessions connected.\n", thread_id);
  } else {
    printf("large_rpc_tput: Thread %zu: No sessions created.\n", thread_id);
  }

  // All threads allocate MsgBuffers, but they may not send requests
  alloc_req_resp_msg_buffers(&c);

  size_t console_ref_tsc = erpc::rdtsc();

  #ifdef run_flow_distribution
  if (c.session_num_vec_.size() > 0) {
    generate_distribution();
  }
  #endif

  // Any thread that creates a session sends requests
  if (c.session_num_vec_.size() > 0) {
    for (size_t msgbuf_idx = 0; msgbuf_idx < FLAGS_concurrency; msgbuf_idx++) {
      send_req(&c, msgbuf_idx);
    }
  }

  while(!c.session_num_vec_.size() && !c.stat_rx_bytes_tot){  
    rpc.run_event_loop_do_one_st();
    if (unlikely(ctrl_c_pressed == 1)) break;
  }
  c.tput_t0.reset();
  double ns = 0;
  for (size_t i = 0; i < FLAGS_test_ms; i += kAppEvLoopMs) {
    #ifdef run_flow_distribution
      while(true){
        rpc.run_event_loop_do_one_st();
        if (unlikely(ctrl_c_pressed == 1)) break;
        if(c.stat_tx_bytes_tot >= transmission || c.stat_rx_bytes_tot >= transmission) break;
      }
    #else
      rpc.run_event_loop(kAppEvLoopMs);
    #endif

    if (unlikely(ctrl_c_pressed == 1)) break;
    if (c.session_num_vec_.size() == 0) continue;  // server do not print stats

    ns = c.tput_t0.get_ns();
    erpc::Timely *timely_0 = c.rpc_->get_timely(0);

    auto &stats = c.app_stats[c.thread_id_];
    stats.rx_gbps = c.stat_rx_bytes_tot * 8 / ns;
    stats.tx_gbps = c.stat_tx_bytes_tot * 8 / ns;
    stats.re_tx = c.rpc_->get_num_re_tx(c.session_num_vec_[0]);
    stats.rtt_50_us = timely_0->get_rtt_perc(0.50);
    stats.rtt_99_us = timely_0->get_rtt_perc(0.99);

    if (c.lat_vec.size() > 0) {
      std::sort(c.lat_vec.begin(), c.lat_vec.end());
      stats.rpc_50_us = c.lat_vec[c.lat_vec.size() * 0.50];
      stats.rpc_99_us = c.lat_vec[c.lat_vec.size() * 0.99];
      stats.rpc_999_us = c.lat_vec[c.lat_vec.size() * 0.999];
    } else {
      // Even if no RPCs completed, we need retransmission counter
      stats.rpc_50_us = kAppEvLoopMs * 1000;
      stats.rpc_99_us = kAppEvLoopMs * 1000;
      stats.rpc_999_us = kAppEvLoopMs * 1000;
    }

    bool server = (c.rpc_->session_vec_[0])->is_server();
    size_t tx_size = server ? FLAGS_resp_size : FLAGS_req_size;
    size_t rx_size = server ? FLAGS_req_size : FLAGS_resp_size;

    // printf(
    //     "large_rpc_tput: Thread %zu: Tput {RX %.2f (%zu), TX %.2f (%zu)} "
    //     "Gbps (IOPS).\n",
    //     c.thread_id_, stats.rx_gbps, c.stat_rx_bytes_tot/rx_size,
    //     stats.tx_gbps, c.stat_tx_bytes_tot/tx_size);

    printf(
        "large_rpc_tput: Thread %zu: Tput {RX %.2f (%zu), TX %.2f (%zu)} "
        "Gbps (IOPS).Retransmissions %zu."
        "RPC latency {%.1f 50th, %.1f 99th, %.1f 99.9th}.\n",
        c.thread_id_, stats.rx_gbps, c.stat_rx_bytes_tot / rx_size,
        stats.tx_gbps, c.stat_tx_bytes_tot / tx_size, stats.re_tx, stats.rpc_50_us, stats.rpc_99_us,
        stats.rpc_999_us);

    c.stat_rx_bytes_tot = 0;
    c.stat_tx_bytes_tot = 0;
    c.rpc_->reset_num_re_tx(c.session_num_vec_[0]);
    c.lat_vec.clear();
    timely_0->reset_rtt_stats();

    if (c.thread_id_ == 0) {
      app_stats_t accum_stats;
      for (size_t i = 0; i < FLAGS_num_client_fg_threads; i++) {
        accum_stats += c.app_stats[i];
      }

      // Compute averages for non-additive stats
      accum_stats.rtt_50_us /= FLAGS_num_client_fg_threads;
      accum_stats.rtt_99_us /= FLAGS_num_client_fg_threads;
      accum_stats.rpc_50_us /= FLAGS_num_client_fg_threads;
      accum_stats.rpc_99_us /= FLAGS_num_client_fg_threads;
      accum_stats.rpc_999_us /= FLAGS_num_client_fg_threads;
      c.tmp_stat_->write(accum_stats.to_string());
    }

    if(server){
      while(c.stat_rx_bytes_tot == 0){
        rpc.run_event_loop_do_one_st();
        if (unlikely(ctrl_c_pressed == 1)) break;
      }
    }
    #ifdef run_flow_distribution
    if(!server){
      generate_distribution();
    }
    #endif
    c.tput_t0.reset();
  }

  // erpc::print_stat(c.rpc_->get_freq_ghz());
  // printf("Thread %zu, freq:%f\n", c.thread_id_, c.rpc_->get_freq_ghz());

  erpc::TimingWheel *wheel = rpc.get_wheel();
  if (wheel != nullptr && !wheel->record_vec_.empty()) {
    const size_t num_to_print = 200;
    const size_t tot_entries = wheel->record_vec_.size();
    const size_t base_entry = tot_entries * .9;

    printf("Printing up to 200 entries toward the end of wheel record\n");
    size_t num_printed = 0;

    for (size_t i = base_entry; i < tot_entries; i++) {
      auto &rec = wheel->record_vec_.at(i);
      printf("wheel: %s\n",
             rec.to_string(console_ref_tsc, rpc.get_freq_ghz()).c_str());

      if (num_printed++ == num_to_print) break;
    }
  }

  // We don't disconnect sessions
}

// Use the supplied profile set up globals and possibly modify other flags
void setup_profile() {
  if (FLAGS_profile == "incast") {
    connect_sessions_func = connect_sessions_func_incast;
    return;
  }

  if (FLAGS_profile == "victim") {
    erpc::rt_assert(FLAGS_num_processes >= 3, "Too few processes");
    erpc::rt_assert(FLAGS_num_client_fg_threads >= 2, "Too few threads");
    connect_sessions_func = connect_sessions_func_victim;
    return;
  }
}

int main(int argc, char **argv) {
  signal(SIGINT, ctrl_c_handler);
  gflags::ParseCommandLineFlags(&argc, &argv, true);
  erpc::rt_assert(FLAGS_concurrency <= kAppMaxConcurrency, "Invalid conc");
  erpc::rt_assert(FLAGS_profile == "incast" || FLAGS_profile == "victim",
                  "Invalid profile");
  erpc::rt_assert(FLAGS_process_id < FLAGS_num_processes, "Invalid process ID");

  if (!erpc::kTesting) {
    erpc::rt_assert(FLAGS_drop_prob == 0.0, "Invalid drop prob");
  } else {
    erpc::rt_assert(FLAGS_drop_prob < 1, "Invalid drop prob");
  }

  setup_profile();
  erpc::rt_assert(connect_sessions_func != nullptr, "No connect_sessions_func");

  erpc::rt_assert(FLAGS_bgthread_req_percent == 0 || FLAGS_num_server_bg_threads != 0, "server has no bgthreads, bgthread_req_percent should be 0");
  size_t num_bg_threads = FLAGS_process_id == 0 ? FLAGS_num_server_bg_threads
                                             : FLAGS_num_client_bg_threads;

  erpc::Nexus nexus(erpc::get_uri_for_process(FLAGS_process_id),
                    FLAGS_numa_node, num_bg_threads);

  nexus.register_req_func(kAppReqType_Fg, req_handler, erpc::ReqFuncType::kForeground);
  if(num_bg_threads) nexus.register_req_func(kAppReqType_Bg, req_handler, erpc::ReqFuncType::kBackground);

  size_t num_threads = FLAGS_process_id == 0 ? FLAGS_num_server_fg_threads
                                             : FLAGS_num_client_fg_threads;
  std::vector<std::thread> threads(num_threads);
  auto *app_stats = new app_stats_t[num_threads];

  for (size_t i = 0; i < num_threads; i++) {
    threads[i] = std::thread(thread_func, i, app_stats, &nexus);
    erpc::bind_to_core(threads[i], FLAGS_numa_node, i);
  }

  for (auto &thread : threads) thread.join();
  delete[] app_stats;
}
