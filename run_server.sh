cd ~/eRPC
if [ 'make' == $1 ]; then
    make -j > ~/outputs.txt 2>&1
    sleep 4
elif [ 'run' == $1 ]; then
    sed -i "1s/.*/--test_ms 100000/" apps/large_rpc_tput/config
    sed -i "35s/.*/#define MACHINE_IP TACC_SERVER_IP/" src/rpc.h
    sed -i "36s/.*/#define MACHINE_MAC TACC_SERVER_MAC/" src/rpc.h
    make large_rpc_tput >> ~/outputs.txt 2>&1
    sudo kill -9 $(ps aux | grep "do.sh" | awk '{print $2}')
    sudo kill -9 $(ps aux | grep "large_rpc_tput" | awk '{print $2}')
    sleep 5
    nohup sudo ./scripts/do.sh 0 0 >> ~/outputs.txt 2>&1 &
    sleep 10
fi