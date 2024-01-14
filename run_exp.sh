server_ip='192.168.0.212'
username='qijing'
numa=1

echo "" > ~/info.txt
echo "" > ~/result.txt
for i in "$@"; do

    if [ 'tx_sin_core' == $i ] || [ 'all' == $1 ]; then
        echo "begin test of TX, Single Core" >> ~/result.txt
        sed -i "41s/.*/#define KeepSend/" src/rpc.h
        scp src/rpc.h "$username@$server_ip:~/eRPC/src/"
        ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh make"
        make -j
        for size in {8,72,200,456,968}
        do
            cp apps/large_rpc_tput/config_template apps/large_rpc_tput/config
            sed -i "2s/.*/--req_size $size/" apps/large_rpc_tput/config
            scp apps/large_rpc_tput/config "$username@$server_ip:~/eRPC/apps/large_rpc_tput/"
            max_mpps=0
            mpps=0
            echo "test of $size" >> ~/result.txt
            for((i=0;i<3;i++))
            do
                ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh run"
                make large_rpc_tput
                echo "begin test $size" >> ~/info.txt
                sudo ./scripts/do.sh 1 $numa >> ~/info.txt
                mpps=$(cat ~/info.txt | tail -n 1 | awk '{print $10}')
                mpps=${mpps:1:0-2}
                if [ $mpps -gt $max_mpps ]; then
                    max_mpps=$mpps
                fi
            done
            echo "$max_mpps" >> ~/result.txt
        done
    fi

    if [ 'tx_mul_core' == $i ]|| [ 'all' == $1 ]; then
        echo "begin test of TX, Multiple Cores" >> ~/result.txt
        sed -i "41s/.*/#define KeepSend/" src/rpc.h
        scp src/rpc.h "$username@$server_ip:~/eRPC/src/"
        ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh make"
        make -j
        for thread in {1,2,4,8,16}
        do 
            for size in {8,456}
            do
                cp apps/large_rpc_tput/config_template apps/large_rpc_tput/config
                sed -i "2s/.*/--req_size $size/" apps/large_rpc_tput/config
                sed -i "7s/.*/--num_proc_0_threads $thread/" apps/large_rpc_tput/config
                sed -i "8s/.*/--num_proc_other_threads $thread/" apps/large_rpc_tput/config
                scp apps/large_rpc_tput/config "$username@$server_ip:~/eRPC/apps/large_rpc_tput/"
                max_mpps=0
                echo "test of thread[$thread] size[$size] " >> ~/result.txt
                for((i=0;i<3;i++))
                do
                    ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh run"
                    make large_rpc_tput
                    echo "begin test thread[$thread] size[$size]" >> ~/info.txt
                    sudo ./scripts/do.sh 1 $numa >> ~/info.txt
                    tmp_mpps=0
                    mpps=0
                    for((line=1;line<=$thread;line++))
                    do
                        tmp_mpps=$(cat ~/info.txt | tail -n $line | head -n 1 | awk '{print $10}')
                        tmp_mpps=${tmp_mpps:1:0-2}
                        mpps=$[mpps+tmp_mpps]
                    done
                    if [ $mpps -gt $max_mpps ]; then
                        max_mpps=$mpps
                    fi
                done
                echo "$max_mpps" >> ~/result.txt
            done
        done
    fi

    if [ 'sp_sin_core' == $i ]|| [ 'all' == $1 ]; then
        echo "begin test of Small Response, Single Core" >> ~/result.txt
        sed -i "41s/.*/\/\/ #define KeepSend/" src/rpc.h
        scp src/rpc.h "$username@$server_ip:~/eRPC/src/"
        ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh make"
        make -j
        for size in {8,72,200,456,968}
        do
            cp apps/large_rpc_tput/config_template apps/large_rpc_tput/config
            sed -i "2s/.*/--req_size $size/" apps/large_rpc_tput/config
            scp apps/large_rpc_tput/config "$username@$server_ip:~/eRPC/apps/large_rpc_tput/"
            max_mpps=0
            mpps=0
            echo "test of $size" >> ~/result.txt
            for((i=0;i<3;i++))
            do
                ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh run"
                make large_rpc_tput
                echo "begin test $size" >> ~/info.txt
                sudo ./scripts/do.sh 1 $numa >> ~/info.txt
                mpps=$(cat ~/info.txt | tail -n 1 | awk '{print $10}')
                mpps=${mpps:1:0-2}
                if [ $mpps -gt $max_mpps ]; then
                    max_mpps=$mpps
                fi
            done
            echo "$max_mpps" >> ~/result.txt
        done
    fi

    if [ 'sp_mul_core' == $i ]|| [ 'all' == $1 ]; then
        echo "begin test of Small Response, Multiple Cores" >> ~/result.txt
        sed -i "41s/.*/\/\/ #define KeepSend/" src/rpc.h
        scp src/rpc.h "$username@$server_ip:~/eRPC/src/"
        ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh make"
        make -j
        for thread in {1,2,4,8,16}
        do 
            for size in {8,456}
            do
                cp apps/large_rpc_tput/config_template apps/large_rpc_tput/config
                sed -i "2s/.*/--req_size $size/" apps/large_rpc_tput/config
                sed -i "7s/.*/--num_proc_0_threads $thread/" apps/large_rpc_tput/config
                sed -i "8s/.*/--num_proc_other_threads $thread/" apps/large_rpc_tput/config
                scp apps/large_rpc_tput/config "$username@$server_ip:~/eRPC/apps/large_rpc_tput/"
                max_mpps=0
                echo "test of thread[$thread] size[$size] " >> ~/result.txt
                for((i=0;i<3;i++))
                do
                    ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh run"
                    make large_rpc_tput
                    echo "begin test thread[$thread] size[$size]" >> ~/info.txt
                    sudo ./scripts/do.sh 1 $numa >> ~/info.txt
                    tmp_mpps=0
                    mpps=0
                    for((line=1;line<=$thread;line++))
                    do
                        tmp_mpps=$(cat ~/info.txt | tail -n $line | head -n 1 | awk '{print $10}')
                        tmp_mpps=${tmp_mpps:1:0-2}
                        mpps=$[mpps+tmp_mpps]
                    done
                    if [ $mpps -gt $max_mpps ]; then
                        max_mpps=$mpps
                    fi
                done
                echo "$max_mpps" >> ~/result.txt
            done
        done
    fi

    if [ 'ec_sin_core' == $i ]|| [ 'all' == $1 ]; then
        echo "begin test of Echo, Single Core" >> ~/result.txt
        sed -i "41s/.*/\/\/ #define KeepSend/" src/rpc.h
        scp src/rpc.h "$username@$server_ip:~/eRPC/src/"
        ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh make"
        make -j
        for size in {8,72,200,456,968}
        do
            cp apps/large_rpc_tput/config_template apps/large_rpc_tput/config
            sed -i "2s/.*/--req_size $size/" apps/large_rpc_tput/config
            sed -i "5s/.*/--resp_size $size/" apps/large_rpc_tput/config
            scp apps/large_rpc_tput/config "$username@$server_ip:~/eRPC/apps/large_rpc_tput/"
            max_mpps=0
            mpps=0
            echo "test of $size" >> ~/result.txt
            for((i=0;i<3;i++))
            do
                ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh run"
                make large_rpc_tput
                echo "begin test $size" >> ~/info.txt
                sudo ./scripts/do.sh 1 $numa >> ~/info.txt
                mpps=$(cat ~/info.txt | tail -n 1 | awk '{print $10}')
                mpps=${mpps:1:0-2}
                if [ $mpps -gt $max_mpps ]; then
                    max_mpps=$mpps
                fi
            done
            echo "$max_mpps" >> ~/result.txt
        done
    fi

    if [ 'ec_mul_core' == $i ]|| [ 'all' == $1 ]; then
        echo "begin test of Echo, Multiple Cores" >> ~/result.txt
        sed -i "41s/.*/\/\/ #define KeepSend/" src/rpc.h
        scp src/rpc.h "$username@$server_ip:~/eRPC/src/"
        ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh make"
        make -j
        for thread in {1,2,4,8,16}
        do 
            for size in {8,456}
            do
                cp apps/large_rpc_tput/config_template apps/large_rpc_tput/config
                sed -i "2s/.*/--req_size $size/" apps/large_rpc_tput/config
                sed -i "5s/.*/--resp_size $size/" apps/large_rpc_tput/config
                sed -i "7s/.*/--num_proc_0_threads $thread/" apps/large_rpc_tput/config
                sed -i "8s/.*/--num_proc_other_threads $thread/" apps/large_rpc_tput/config
                scp apps/large_rpc_tput/config "$username@$server_ip:~/eRPC/apps/large_rpc_tput/"
                max_mpps=0
                echo "test of thread[$thread] size[$size] " >> ~/result.txt
                for((i=0;i<3;i++))
                do
                    ssh -tt "$username@$server_ip" "bash eRPC/run_server.sh run"
                    make large_rpc_tput
                    echo "begin test thread[$thread] size[$size]" >> ~/info.txt
                    sudo ./scripts/do.sh 1 $numa >> ~/info.txt
                    tmp_mpps=0
                    mpps=0
                    for((line=1;line<=$thread;line++))
                    do
                        tmp_mpps=$(cat ~/info.txt | tail -n $line | head -n 1 | awk '{print $10}')
                        tmp_mpps=${tmp_mpps:1:0-2}
                        mpps=$[mpps+tmp_mpps]
                    done
                    if [ $mpps -gt $max_mpps ]; then
                        max_mpps=$mpps
                    fi
                done
                echo "$max_mpps" >> ~/result.txt
            done
        done
    fi

done