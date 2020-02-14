ids=`ps -aux|grep ssserver|grep -v 'grep'|awk '{print $2}'`
for id in ${ids[@]}
do
	kill -9 $id
done
