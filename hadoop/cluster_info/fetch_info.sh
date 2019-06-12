echo "# 获取集群信息"
pcs=`cat machines`
keys="NameNode|SecondaryNameNode|DataNode|NodeManager|ResourceManager"

for i in ${pcs[@]}
do
  echo "NODE: $i"
  ssh $i jps|grep -E ${keys}
  echo ""
done