#!/usr/bin/env bash
#http://www.cnblogs.com/chengmo/archive/2010/10/02/1841355.html
p(){
    echo "*********************************************************************";
}
#/d/phpStudy/WWW/learn-shell/commond/string
path=`pwd`
echo $path
# 42
echo ${#path}
#d/phpStudy/WWW/learn-shell/commond/string
echo ${path#/}
echo ${path#*/}
echo ${path##*/}
#${变量名#substring正则表达式}从字符串开头开始配备substring,删除匹配上的表达式。
#${变量名%substring正则表达式}从字符串结尾开始配备substring,删除匹配上的表达式。
#注意：${test##*/},${test%/*} 分别是得到文件名，或者目录地址最简单方法。

#/d/phpStudy/WWW/learn-shell/commond
echo ${path%/*}
p
echo ${path%/*/*}
p
#/d/phpStudy/WWW
echo ${path%/*/*/*}

#/d/phpStudy/WWW/learn-shell/commond/string
echo ${path}
#\d/phpStudy/WWW/learn-shell/commond/string
echo ${path/\//\\}
#todo why ??
echo ${path/\/\//\\}
#${变量/查找/替换值} 一个“/”表示替换第一个，”//”表示替换所有,当查找中出现了：”/”请加转义符”\/”表示。
#for i in `seq 100`;do
#    p
#    date
#    sleep 1
#done

