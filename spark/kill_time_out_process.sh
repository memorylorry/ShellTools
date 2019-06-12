# 当进程超过${TIME_OUT_HOUR}时长，调用此脚本可以kill掉
# HADOOP VERSION : 2.7.0
# JDK VERSION : 1.7.*
TIME_OUT_HOUR=3
GREP_KEY_WORD="Flink session cluster"
#GREP_KEY_WORD="hive-on-spark-1.6.3"
#GREP_KEY_WORD="MAPREDUCE"

# fetch app list
appid=`yarn application -list  -appStates RUNNING | grep "${GREP_KEY_WORD}" | awk '{print $1}'`

# itreator the list and kill timeout process
for i in ${appid[@]}
do
    starttime=`yarn application -status $i | grep "Start-Time" | awk '{print $3}'`
    now=`date +%s`
    # count how long have the process run.
    takeHour=`expr $[$now - $starttime / 1000] / 3600`
    # print process info
    if [ $takeHour -gt $TIME_OUT_HOUR ];then
       # kill this process
       echo "[x] APPID: $i [StartTime: $starttime -> NOW: $now _@takeHour: $takeHour ]"
       #yarn application -kill $i
    else
       echo "[r] APPID: $i [StartTime: $starttime -> NOW: $now _@takeHour: $takeHour ]"
    fi 
done