server_ip='192.168.1.137'
username='qijing'
echo "" > ~/info.txt
echo "" > ~/result.txt

if [ 'tx_sin_core' == $1 ] || [ 'all' == $1 ]; then
    echo "begin test of TX, Single Core" >> ~/result.txt
    sed -i "24s/.*/#define KeepSend/" src/rpc.h
    scp src/rpc.h "$username@$server_ip:~/eRPC/src/"
    ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh make"
    make -j
    for size in {8,72,200,456,968}
    do
        cp apps/large_rpc_tput/config_template apps/large_rpc_tput/config
        sed -i "2s/.*/--req_size $size/" apps/large_rpc_tput/config
        scp apps/large_rpc_tput/config "$username@$server_ip:~/eRPC/apps/large_rpc_tput/"
        ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh run"
        make large_rpc_tput
        sudo ./scripts/do.sh 1 0 >> ~/info.txt
        echo "test of $size" >> ~/result.txt
        cat ~/info.txt | tail -n 1 >> ~/result.txt
        echo "finish $size" >> ~/info.txt
    done
fi

if [ 'tx_mul_core' == $1 ]|| [ 'all' == $1 ]; then
    echo "begin test of TX, Multiple Cores" >> ~/result.txt
    sed -i "24s/.*/#define KeepSend/" src/rpc.h
    scp src/rpc.h "$username@$server_ip:~/eRPC/src/"
    ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh make"
    make -j
    for thread in {1,2,4,8,16}
    do 
        for size in {8,200}
        do
            cp apps/large_rpc_tput/config_template apps/large_rpc_tput/config
            sed -i "2s/.*/--req_size $size/" apps/large_rpc_tput/config
            sed -i "7s/.*/--num_proc_0_threads $thread/" apps/large_rpc_tput/config
            sed -i "8s/.*/--num_proc_other_threads $thread/" apps/large_rpc_tput/config
            scp apps/large_rpc_tput/config "$username@$server_ip:~/eRPC/apps/large_rpc_tput/"
            ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh run"
            make large_rpc_tput
            sudo ./scripts/do.sh 1 0 >> ~/info.txt
            echo "test of thread[$thread] size[$size] " >> ~/result.txt
            cat ~/info.txt | tail -n $thread >> ~/result.txt
            echo "finish thread[$thread] size[$size]" >> ~/info.txt
        done
    done
fi

if [ 'sp_sin_core' == $1 ]|| [ 'all' == $1 ]; then
    echo "begin test of Small Response, Single Core" >> ~/result.txt
    sed -i "24s/.*/\/\/ #define KeepSend/" src/rpc.h
    scp src/rpc.h "$username@$server_ip:~/eRPC/src/"
    ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh make"
    make -j
    for size in {8,72,200,456,968}
    do
        cp apps/large_rpc_tput/config_template apps/large_rpc_tput/config
        sed -i "2s/.*/--req_size $size/" apps/large_rpc_tput/config
        scp apps/large_rpc_tput/config "$username@$server_ip:~/eRPC/apps/large_rpc_tput/"
        ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh run"
        make large_rpc_tput
        sudo ./scripts/do.sh 1 0 >> ~/info.txt
        echo "test of $size" >> ~/result.txt
        cat ~/info.txt | tail -n 1 >> ~/result.txt
        echo "finish $size" >> ~/info.txt
    done
fi

if [ 'sp_mul_core' == $1 ]|| [ 'all' == $1 ]; then
    echo "begin test of Small Response, Multiple Cores" >> ~/result.txt
    sed -i "24s/.*/\/\/ #define KeepSend/" src/rpc.h
    scp src/rpc.h "$username@$server_ip:~/eRPC/src/"
    ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh make"
    make -j
    for thread in {1,2,4,8,16}
    do 
        for size in {8,200}
        do
            cp apps/large_rpc_tput/config_template apps/large_rpc_tput/config
            sed -i "2s/.*/--req_size $size/" apps/large_rpc_tput/config
            sed -i "7s/.*/--num_proc_0_threads $thread/" apps/large_rpc_tput/config
            sed -i "8s/.*/--num_proc_other_threads $thread/" apps/large_rpc_tput/config
            scp apps/large_rpc_tput/config "$username@$server_ip:~/eRPC/apps/large_rpc_tput/"
            ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh run"
            make large_rpc_tput
            sudo ./scripts/do.sh 1 0 >> ~/info.txt
            echo "test of thread[$thread] size[$size] " >> ~/result.txt
            cat ~/info.txt | tail -n $thread >> ~/result.txt
            echo "finish thread[$thread] size[$size]" >> ~/info.txt
        done
    done
fi

if [ 'ec_sin_core' == $1 ]|| [ 'all' == $1 ]; then
    echo "begin test of Echo, Single Core" >> ~/result.txt
    sed -i "24s/.*/\/\/ #define KeepSend/" src/rpc.h
    scp src/rpc.h "$username@$server_ip:~/eRPC/src/"
    ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh make"
    make -j
    for size in {8,72,200,456,968}
    do
        cp apps/large_rpc_tput/config_template apps/large_rpc_tput/config
        sed -i "2s/.*/--req_size $size/" apps/large_rpc_tput/config
        sed -i "5s/.*/--resp_size $size/" apps/large_rpc_tput/config
        scp apps/large_rpc_tput/config "$username@$server_ip:~/eRPC/apps/large_rpc_tput/"
        ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh run"
        make large_rpc_tput
        sudo ./scripts/do.sh 1 0 >> ~/info.txt
        echo "test of $size" >> ~/result.txt
        cat ~/info.txt | tail -n 1 >> ~/result.txt
        echo "finish $size" >> ~/info.txt
    done
fi

if [ 'ec_mul_core' == $1 ]|| [ 'all' == $1 ]; then
    echo "begin test of Echo, Multiple Cores" >> ~/result.txt
    sed -i "24s/.*/\/\/ #define KeepSend/" src/rpc.h
    scp src/rpc.h "$username@$server_ip:~/eRPC/src/"
    ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh make"
    make -j
    for thread in {1,2,4,8,16}
    do 
        for size in {8,200}
        do
            cp apps/large_rpc_tput/config_template apps/large_rpc_tput/config
            sed -i "2s/.*/--req_size $size/" apps/large_rpc_tput/config
            sed -i "5s/.*/--resp_size $size/" apps/large_rpc_tput/config
            sed -i "7s/.*/--num_proc_0_threads $thread/" apps/large_rpc_tput/config
            sed -i "8s/.*/--num_proc_other_threads $thread/" apps/large_rpc_tput/config
            scp apps/large_rpc_tput/config "$username@$server_ip:~/eRPC/apps/large_rpc_tput/"
            ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh run"
            make large_rpc_tput
            sudo ./scripts/do.sh 1 0 >> ~/info.txt
            echo "test of thread[$thread] size[$size] " >> ~/result.txt
            cat ~/info.txt | tail -n $thread >> ~/result.txt
            echo "finish thread[$thread] size[$size]" >> ~/info.txt
        done
    done
fi