# so
This is a SSH login tool

## Linux ssh 登陆工具:

### 一.说明
- 支持秘密和密钥两种格式
- 用户名和密码都是写文件的,明文保存

### 二.配置
- 密码文件配置:

序号:IP:端口:用户:密码:说明
1:192.168.88.128:22:root:toor:虚拟机web服务器

- 密钥文件放在keys文件夹下,密码位置写成密钥文件名,文件名必须以.pem结尾

### 三.使用方法

直接执行connect.sh即可提示。

### 四.下载

wget https://raw.githubusercontent.com/memorylorry/ShellTools/master/linkshell/connect.sh

wget https://raw.githubusercontent.com/memorylorry/ShellTools/master/linkshell/password.lst

wget https://raw.githubusercontent.com/memorylorry/ShellTools/master/linkshell/ssh_login.exp