# 下载
wget https://raw.githubusercontent.com/memorylorry/ShellTools/master/shadowsock/PORT_VAL
wget https://raw.githubusercontent.com/memorylorry/ShellTools/master/shadowsock/ss.sh
wget https://raw.githubusercontent.com/memorylorry/ShellTools/master/shadowsock/servercfg.json

# 更改权限
chmod +x ss.sh

# 处理bug
ss_dir='/usr/local/lib/python3.6/site-packages/shadowsocks/crypto'
if [ -d $ss_dir ]; then
  cat /usr/local/lib/python3.6/site-packages/shadowsocks/crypto/openssl.py | awk '{ gsub(/EVP_CIPHER_CTX_resetxxx/,"EVP_CIPHER_CTX_reset"); print $0 }' > tmp.txt
  cat tmp.txt > /usr/local/lib/python3.6/site-packages/shadowsocks/crypto/openssl.py
  echo "solve bug!"
fi


# 安装并启动
./ss.sh i
./ss.sh server start
