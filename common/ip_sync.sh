source /etc/profile

# PARAM
name=cv2
#http://localhost:8080/pub/reportInfo/report?name=cv2&info=172.27.0.1&infoType=ip2
url=http://monitor.huqian.org/pub/reportInfo/report

# get IP
ip=`/usr/sbin/ifconfig|grep inet|grep broadcast|awk '{print $2}'`
report_url="$url?name=$name&info=$ip&infoType=ip"
#echo $report_url
# transfer information
curl -i "$report_url"
