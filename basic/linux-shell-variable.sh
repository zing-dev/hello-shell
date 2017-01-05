#!/usr/bin/env bash
# -*- coding: utf-8 -*-

#Shell 变量
#定义变量时，变量名不加美元符号（$，PHP语言中变量需要）

#首个字符必须为字母（a-z，A-Z）。
#中间不能有空格，可以使用下划线（_）。
#不能使用标点符号。
#不能使用bash里的关键字（可用help命令查看保留关键字）
name="zing"
echo $name
echo ${name}

url="github.com"
echo $url
readonly url
#url="wocao"
#unset url

unset name
echo $name #nothing


#变量类型
#运行shell时，会同时存在三种变量：
#1) 局部变量 局部变量在脚本或命令中定义，仅在当前shell实例中有效，其他shell启动的程序不能访问局部变量。
#2) 环境变量 所有的程序，包括shell启动的程序，都能访问环境变量，有些程序需要环境变量来保证其正常运行。必要的时候shell脚本也可以定义环境变量。
#3) shell变量 shell变量是由shell程序设置的特殊变量。shell变量中有一部分是环境变量，有一部分是局部变量，这些变量保证了shell的正常运行

#单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的；
#单引号字串中不能出现单引号（对单引号使用转义符后也不行）。
str='this is a string'
echo $str
str='\this \is \a \string'
echo $str  # no change

#双引号里可以有变量
#双引号里可以出现转义字符
name='zing'
str="Hello, I know your are \"$name\"!"
echo $str

#拼接字符串
greeting="hello, "$name" !"
greeting_1="hello, ${name} !"
echo $greeting $greeting_1

#获取字符串长度"
echo ${#str} #  输出 4串长度
echo ${#name} # 输出 4串长度

#提取子字符串
string="runoob is a great site"
echo ${string:1:4} # 输出 unoo
echo ${str:0:${#str}}
echo ${str:0:${#str}-20}
echo ${str:0:${#str}-25}

#查找子字符串
string="runoob is a great company"
echo `expr index "$string" is`  # 输出 8
echo `expr index "$string" r`


#Shell 数组
#bash支持一维数组（不支持多维数组），并且没有限定数组的大小。
#类似与C语言，数组元素的下标由0开始编号。获取数组中的元素要利用下标，下标可以是整数或算术表达式，其值应大于或等于0。

#数组名=(值1 值2 ... 值n)
arr=(11 22 33 44 55)
echo $arr
echo ${arr[1]}
echo ${arr[2]}
arr[0]=000
arr[1]=111
arr[2]=222
echo ${arr[1]}
echo ${arr[2]}
echo ${arr[@]}

#获取数组的长度
echo ${#arr[@]}
echo ${#arr[*]}

#取得数组单个元素的长度
echo ${#arr[0]}

