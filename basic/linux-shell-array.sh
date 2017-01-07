#!/usr/bin/env bash

#Bash Shell 只支持一维数组（不支持多维数组）
#Shell 数组用括号来表示，元素用"空格"符号分割开，语法格式如下

arr=(11 22 33 44 55)
echo $arr

echo ${arr[0]}
echo ${arr[1]}
echo ${arr[2]}


arr=("zing" "hly" 22 21)
echo ${arr[@]}
echo ${arr[*]}

for i in ${arr[*]};do
    echo $i
done

for i in ${arr[@]};do
    echo $i
done

echo "length :" ${#arr}
echo ${arr[0]}
echo "${arr[1]}"


