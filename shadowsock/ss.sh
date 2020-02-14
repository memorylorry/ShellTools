# 端口
PORT=9000
# 密码
PASS=9527
# 加密方法
METHOD="aes-256-cfb"
# sslocal所用的IP
IP=127.0.0.1

# 获取端口，并回写端口增1
get_port(){
    PORT=`cat PORT_VAL`
    PORT_NEXT=`expr $PORT + 1`
    echo $PORT_NEXT > "PORT_VAL"
    # echo $PORT
    return $PORT
}

# 启动服务端
start_server(){
    get_port
    ssserver -p $PORT -k $PASS -m $METHOD --workers 10 --pid-file /tmp/ss.pid --log-file /tmp/ss.log -d start

    echo "端口： "$PORT
    echo "密码： "$PASS
    echo "加密方式： "$METHOD
}

# 杀死服务器
kill_server(){
    ids=`ps -aux|grep ssserver|grep -v 'grep'|awk '{print $2}'`
    for id in ${ids[@]}
    do
        kill -9 $id
        echo 'kill -9 $id'
    done
}

# 启动客户端
start_client(){
    get_port
    sslocal -s $IP -p $PORT -b 127.0.0.1 -l 1080 -k $PASS -t 300 -m $METHOD -d start
    echo "IP： "$IP
    echo "端口： "$PORT
    echo "密码： "$PASS
    echo "加密方式： "$METHOD
}

# 杀死客户端
kill_client(){
    id=`ps -aux|grep sslocal|grep -v 'grep'|awk '{print $2}'`
    kill -9 $id
    echo "kill -9 $id"
}

# 安装服务器
install(){
    # 下载pip 并 安装
    curl --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | python
    # 安装shadowsocks
    pip install shadowsocks
}


### MAIN:
if [ "$3" != "" ];then
    IP=$3
fi

if [ "$1" = "i" ];then
    install
elif [ "$1" = "server" ];then
    if [ "$2" = "start" ];then
        # 启动服务  
        start_server
    elif [ "$2" = "stop" ];then
        # 停止服务
        kill_server
    else
        # 重启服务
        kill_server
        start_server
    fi
elif [ "$1" = "client" ];then
    if [ "$2" = "start" ];then
        # 启动服务
        start_client
    elif [ "$2" = "stop" ];then
        # 停止服务
        kill_client
    else
        # 重启服务
        start_client
        kill_client
    fi
else
    echo '# ss.sh 用法：'
    echo './ss.sh server i'
    echo './ss.sh server [ start | stop | restart ]'
    echo './ss.sh client [ start | stop | restart ] [$IP]'
fi
