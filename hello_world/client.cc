#include "common.h"
erpc::Rpc<erpc::CTransport> *rpc;
erpc::MsgBuffer req;
erpc::MsgBuffer resp;

void cont_func(void *, void *) { 
  printf("in continuation function\n");
  printf("%s\n", resp.buf_); 
}

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
  }
  printf("connection build\n");

  req = rpc->alloc_msg_buffer_or_die(kMsgSize);
  resp = rpc->alloc_msg_buffer_or_die(kMsgSize);
  // printf("allocate req & resp buffers, %llx %llx\n", (unsigned long long) req.buf_, (unsigned long long) resp.buf_);

  for (int i = 0; i < 100; i++) {
    rpc->enqueue_request(session_num, kReqType, &req, &resp, cont_func, nullptr);
  }
  rpc->run_event_loop(100000);
  printf("finish client\n");

  delete rpc;
}
