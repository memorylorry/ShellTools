# 端口
PORT=6000
# 密码
PASS=9527
# 加密方法
METHOD="aes-256-cfb"
# sslocal所用的IP
IP=127.0.0.1
# 端口值增长，即在每次重启该脚本时，是否让端口值增加 0-不增 1-增
INC_PORT=0

# 获取端口，并回写端口增1
get_port(){
    PORT=`cat PORT_VAL`
    if [[ $INC_PORT == 1 ]];then
        PORT_NEXT=`expr $PORT + 1`
        echo $PORT_NEXT > "PORT_VAL"
    fi
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
# 使用默认的多用户配置启动服务端
start_server_with_json(){
    get_port
    ssserver -c servercfg.json --workers 10 --pid-file /tmp/ss.pid --log-file /tmp/ss.log -d start
    echo "多用户方式！ "
    echo `cat servercfg.json`
}

# 杀死服务器
kill_server(){
    ids=`ps -aux|grep ssserver|grep -v 'grep'|awk '{print $2}'`
    for id in ${ids[@]}
    do
        kill -9 $id
        echo "kill -9 $id"
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
    elif [ "$2" = "muls" ];then
        # 使用已有配置模板启动服务  
        start_server_with_json
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
        kill_client
        start_client
    fi
else
    echo '# ss.sh 用法：'
    echo './ss.sh i                                       # 安装shadowsocks'
    echo './ss.sh server [ start |muls | stop | restart ]       # 服务端的开启|使用servercfg.json开启多用户|停止|重启'
    echo './ss.sh client [ start | stop | restart ] [$IP] # 服务端的开启|停止|重启'
fi
