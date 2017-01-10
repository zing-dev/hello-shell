#!/usr/bin/env bash
# User: zhangrxiang
# Date: 2017/1/10
# Time: 21:59


#-eq	等于则为真
#-ne	不等于则为真
#-gt	大于则为真
#-ge	大于等于则为真
#-lt	小于则为真
#-le	小于等于则为真

num1=100
num2=100
if test $[num1] -eq $[num2]
then
    echo '== !'
else
    echo '!= !'
fi

#字符串测试
# =	等于则为真
# !=	不相等则为真
#-z 字符串	字符串的长度为零则为真
#-n 字符串	字符串的长度不为零则为真

num1="ru1noob"
num2="runoob"
if test $num1 = $num2
then
    echo '=='
else
    echo '!='
fi


#文件测试
#-e 文件名	如果文件存在则为真
#-r 文件名	如果文件存在且可读则为真
#-w 文件名	如果文件存在且可写则为真
#-x 文件名	如果文件存在且可执行则为真
#-s 文件名	如果文件存在且至少有一个字符则为真
#-d 文件名	如果文件存在且为目录则为真
#-f 文件名	如果文件存在且为普通文件则为真
#-c 文件名	如果文件存在且为字符型特殊文件则为真
#-b 文件名	如果文件存在且为块特殊文件则为真

if test -e ./bash
then
    echo 'EXISTS!'
else
    echo 'NOT EXISTS!'
fi

if test -e ./notFile -o -e ./myfile
then
    echo 'ONE EXISTS!'
else
    echo 'BOTH NO EXISTS'
fi