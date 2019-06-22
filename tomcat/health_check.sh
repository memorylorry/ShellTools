# 这个是为了检测tomcat进程是否占用cpu过高，而开发的重启脚本，推荐放于crontab中执行。
# SET PARAMS
TOMCAT_HOME=/home/bi/tomcat/tomcat
JDK_HOME=/usr/local/jdk1.8.0_171
MAX_CPU=600

# CHECK IF ERR AND RESTART IT
function check(){
  # get cpu rate and pid
   #cpu=`ps -aux|grep "$JDK_HOME/bin/java -Djava.util.logging.config.file=$1/conf"|grep -v 'grep'|awk '{print $3}'`
  pid=`ps -aux|grep "$JDK_HOME/bin/java -Djava.util.logging.config.file=$1/conf"|grep -v 'grep'|awk '{print $2}'`
  cpu=`top -n 1 -p $pid|grep java|awk '{print $11}'`
  
  # check if need to restart server
  cpu=`echo ${cpu%.*}`
  if [ $cpu -gt $MAX_CPU ];then
    echo "[x] HOME: $1  pid: $pid  cpu_rate: $cpu"
    kill -9 $pid
    sleep 7s
    $1/bin/startup.sh
  else
    echo "[ ] HOME: $1  pid: $pid  cpu_rate: $cpu"
  fi 
}

# CALL CHECK
call_check=$(check "$TOMCAT_HOME")
echo $call_check
