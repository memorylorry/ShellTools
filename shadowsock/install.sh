# 端口
PORT=9000
# 密码
PASS=9527
# 加密方法
METHOD="aes-256-cfb"

# 下载pip 并 安装
curl --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | python

# 安装shadowsocks
pip install shadowsocks

ssserver -p $PORT -k $PASS -m $METHOD --workers 10 --pid-file /tmp/ss.pid --log-file /tmp/ss.log -d start

echo "端口： "$PORT
echo "密码： "$PORT
echo "加密方式： "$METHOD
