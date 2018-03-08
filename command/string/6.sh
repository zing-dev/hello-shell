#!/usr/bin/env bash

#表达式	含义
#${var}	变量var的值, 与$var相同
var=`date`
echo $var
echo ${var}
#
#${var-DEFAULT}	如果var没有被声明, 那么就以$DEFAULT作为其值 *
#${var:-DEFAULT}	如果var没有被声明, 或者其值为空, 那么就以$DEFAULT作为其值 *
echo ${var2-defaul2}
var3=''
echo ${var3:-default3}

#${var=DEFAULT}	如果var没有被声明, 那么就以$DEFAULT作为其值 *
#${var:=DEFAULT}	如果var没有被声明, 或者其值为空, 那么就以$DEFAULT作为其值 *
echo ${var4=default4}
var5=
echo ${var5:=${var4}}
echo ${var6:=default6}
#${var+OTHER}	如果var声明了, 那么其值就是$OTHER, 否则就为null字符串
#${var:+OTHER}	如果var被设置了, 那么其值就是$OTHER, 否则就为null字符串
var7=var7777
echo ${var7+${var7}}
echo ${var7+var7}

echo ${var8+var8888}
#${var?ERR_MSG}	如果var没被声明, 那么就打印$ERR_MSG *
#${var:?ERR_MSG}	如果var没被设置, 那么就打印$ERR_MSG *
#echo ${var9?${var7}}
#echo ${var9:?${var7}}
#${!varprefix*}	匹配之前所有以varprefix开头进行声明的变量
#${!varprefix@}	匹配之前所有以varprefix开头进行声明的变量

for i in ${!var*}
do
    echo $i
done

for i in ${!var@}
do
    echo $i
done

echo ${!var@}