cd ~/eRPC
if [ 'make' == $1 ]; then
    make -j > ~/outputs.txt 2>&1
    sleep 10
elif [ 'run' == $1 ]; then
    sed -i "1s/.*/--test_ms 100000/" apps/large_rpc_tput/config
    make large_rpc_tput >> ~/outputs.txt 2>&1
    sudo kill -9 $(ps aux | grep "do.sh" | awk '{print $2}')
    sudo kill -9 $(ps aux | grep "large_rpc_tput" | awk '{print $2}')
    sleep 3
    nohup sudo ./scripts/do.sh 0 0 >> ~/outputs.txt 2>&1 &
    sleep 1
fi