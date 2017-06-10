#!/usr/bin/env bash


#1）!! （连续两个”!”），表示执行上一条指令；
#2）!n（这里的n是数字），表示执行命令历史中第n条指令，例如”!100”表示执行命令历史中第100个命令；
#3）!字符串（字符串大于等于1），例如!ta，表示执行命令历史中最近一次以ta为开头的指令。



#/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/zhangrongxiang/PhpstormProjects/src/phalcon-devtools

file_path='path.txt'
file_env='env.txt'
if [ -e $file_path -a -e $file_env ]; then
    rm -rf $file_path $file_env
else
    echo $PATH >$file_path
    env >$file_env
fi



#【linux shell中的特殊符号】
#1. * ：代表零个或多个字符或数字。


#2. ? ：只代表一个任意的字符