#!/usr/bin/env bash

#$1 第一个参数
#工作时间超过零小时的员工的姓名和工资（薪资乘以时间）

#Beth    4.00    0
#Dan     3.75    0
#kathy   4.00    10
#Mark    5.00    20
#Mary    5.50    22
#Susie   4.25    18


fileName=$1

if [ -e $fileName ]
then
    echo -e "1. 工作时间超过零小时的员工的姓名和工资（薪资乘以时间:"
    awk '$3 >0 { print $1, $2 * $3 }' $fileName
    echo -e "************************************************"
    awk '{print $1,$2,$3}' $fileName
    echo -e "************************************************"
    awk '{print}' $fileName
    echo -e "************************************************"
    awk '$3 > 20 {print}' $fileName
    echo -e "************************************************"
else
    echo "file not exist"
fi

if test -e $2; then
    fileName2=$2
    echo $fileName2 "--"
else
    echo -e "only one file"
fi