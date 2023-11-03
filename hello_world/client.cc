#include <thread>
#include <chrono>
#include "common.h"
erpc::Rpc<erpc::CTransport> *rpc;
erpc::MsgBuffer req;
erpc::MsgBuffer resp;

#define enable_timer std::chrono::time_point<std::chrono::system_clock> _st, _et
#define start_timing  _st = std::chrono::system_clock::now()
#define end_timing(msg)  do {  \
    _et = std::chrono::system_clock::now(); \
    double _elapsed = static_cast<double>(std::chrono::duration_cast<std::chrono::nanoseconds>(_et - _st).count()) / 1000000; \
    printf("[%.3fms] " msg "\n", _elapsed);  \
  } while (0)

void cont_func(void *, void *t) { 
  // printf("%s\n", resp.buf_);
  auto done = static_cast<bool *>(t);
  *done = true;
}

// void cont_func(void *, void *) { 
//   printf("in continuation function\n");
//   printf("%s\n", resp.buf_); 
// }

void sm_handler(int, erpc::SmEventType, erpc::SmErrType, void *) {
  printf("sessions are successfully created or destoryed\n");
}

int main() {
  
  printf("in client\n");
  std::string client_uri = kClientHostname + ":" + std::to_string(kUDPPort_Client);
  erpc::Nexus nexus(client_uri);

  printf("create nexus object\n");
  
  rpc = new erpc::Rpc<erpc::CTransport>(&nexus, nullptr, 0, sm_handler);

  std::string server_uri = kServerHostname + ":" + std::to_string(kUDPPort_Server);
  int session_num = rpc->create_session(server_uri, 0);
  printf("create session %d\n", session_num);

  while (!rpc->is_connected(session_num)){ 
    rpc->run_event_loop_once();
    // printf("retry\n");
  }
  printf("connection build\n");

  req = rpc->alloc_msg_buffer_or_die(kMsgSize);
  resp = rpc->alloc_msg_buffer_or_die(kMsgSize);
  printf("allocate req & resp buffers\n");
  
  enable_timer;
  for(int i = 0; i < 100; i++){
    bool done = false;
    rpc->enqueue_request(session_num, kReqType, &req, &resp, cont_func, static_cast<void *>(&done));
    while (!done) rpc->run_event_loop_once();
    end_timing("rpc latency");
    // std::this_thread::sleep_for(std::chrono::milliseconds(10));
  }
  // rpc->enqueue_request(session_num, kReqType, &req, &resp, cont_func, nullptr);
  // printf("enqueue request return\n");
  // while (true) {
  //   rpc->run_event_loop_once();
  // }
  // rpc->run_event_loop(100);
  printf("finish client\n");

  delete rpc;
}
