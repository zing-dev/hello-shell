#!/usr/bin/env bash

#Bash Shell 只支持一维数组（不支持多维数组）
#Shell 数组用括号来表示，元素用"空格"符号分割开，语法格式如下

arr=( 11 22 33 44 55 )
echo $arr
echo -e "***************************"
echo ${arr[0]}
echo ${arr[1]}
echo ${arr[2]}
echo ${arr[3]}

echo "***************************"
#@ 或 * 可以获取数组中的所有元素
arr=( "zing" "zrx" 22 21 )
echo ${arr[@]}
echo "***************************"
echo ${arr[*]}
echo -e "***************************"

for i in ${arr[*]}; do
    echo $i
done

for i in ${arr[@]}; do
    echo $i
done

echo "length :" ${#arr}
echo ${arr[0]}
echo "${arr[1]}"


for i in `ls`; do
    echo $i | awk '{print "welcome",$1}'
done

if [ -e "1.erl" ]; then
    rm -rf "1.erl"
else
    echo "no this file"
fi