# 参数设置
BASE_PATH="./hadoop/"
DIST_PATH="./jars/"
FILE_TYPE="*.jar"

# 实际执行
files=`find ./hadoop/ -name *.jar`

for file in ${files[@]}
do
  mv $file $DIST_PATH
done

echo "DONE"
