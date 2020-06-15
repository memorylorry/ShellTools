# shadowsock快速部署和使用（适合大部分linux环境）

# 服务端部署

```
# 下载

wget https://raw.githubusercontent.com/memorylorry/ShellTools/master/shadowsock/PORT_VAL

wget https://raw.githubusercontent.com/memorylorry/ShellTools/master/shadowsock/ss.sh

# 更改权限

chmod +x ss.sh

# 安装并启动

./ss.sh i

./ss.sh server start

```

# 客户端部署
```
# 下载

wget https://raw.githubusercontent.com/memorylorry/ShellTools/master/shadowsock/PORT_VAL

wget https://raw.githubusercontent.com/memorylorry/ShellTools/master/shadowsock/ss.sh

# 更改权限

chmod +x ss.sh

# 安装并启动

./ss.sh i

./ss.sh client start
```

# 文件结构
1. ss.sh  管理脚本
2. PORT_VAL 支持自动增长的端口值存放位置