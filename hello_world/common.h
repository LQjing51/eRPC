#include <stdio.h>
#include "rpc.h"

static const std::string kServerHostname = "192.168.1.137";
static const std::string kClientHostname = "192.168.1.131";

static constexpr uint16_t kUDPPort_Server = 31850;
static constexpr uint16_t kUDPPort_Client = 31850;
static constexpr uint8_t kReqType = 2;
static constexpr size_t kMsgSize = 20;
