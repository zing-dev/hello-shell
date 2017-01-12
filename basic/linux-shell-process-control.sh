#!/usr/bin/env bash
# User: zhangrxiang
# Date: 2017/1/11
# Time: 23:22


#if condition
#then
#    command1
#    command2
#    ...
#    commandN
#fi

if [ 1 ]; then echo "true"; fi

a=10
b=20
if [ $a == $b ]
then
    echo "a == b"
elif [ $a -gt $b ]
then
    echo "a > b"
elif [ $a -lt $b ]
then
    echo "a < b"
else
    echo "---------"
fi

num1=$[2*3]
num2=$[1+5]
#if [ $[num1] -eq $[num2] ]
if test $[num1] -eq $[num2]
then
    echo '===========!'
else
    echo '!!!!!======!'
fi


#for 循环

#for var in item1 item2 ... itemN
#do
#    command1
#    command2
#    ...
#    commandN
#done

for loop in 1 2 3 4 5 6 7
do
    echo "The value is: $loop"
done

for str in 'This is a string'
do
    echo $str
done


#while 语句
#while condition
#do
#    command
#done

int=1
while(( $int<=5 ))
do
    echo $int
    let "int++"
done

echo 'PRESS <CTRL-D> EXIT'
echo -n 'INPUT YOU FAVOURITE FILE: '
while read FILM
do
    echo "YES ! $FILM A GOOD FILE"
done


#until 循环
#until循环执行一系列命令直至条件为真时停止。
#until循环与while循环在处理方式上刚好相反。
#一般while循环优于until循环，但在某些时候—也只是极少数情况下，until循环更加有用。
#until 语法格式:



#case
#Shell case语句为多选择语句。可以用case语句匹配一个值与一个模式，
# 如果匹配成功，执行相匹配的命令。case语句格式如下：
#case 值 in
#模式1)
#command1
#command2
#...
#commandN
#;;
#模式2）
#command1
#command2
#...
#commandN
#;;
#esac


echo 'INPUT 1 TO 4 :'
echo 'YOU INPUT IS:'
read aNum
case $aNum in
    1) echo 'YOU CHOICE 1'
    ;;
    2) echo 'YOU CHOICE 2'
    ;;
    3) echo 'YOU CHOICE 3'
    ;;
    4) echo 'YOU CHOICE 4'
    ;;
    *) echo 'YOU DO NOT INPUT 1 TO 4 '
    ;;
esac


#break命令
#break命令允许跳出所有循环（终止执行后面的所有循环）。
#下面的例子中，脚本进入死循环直至用户输入数字大于5。
# 要跳出这个循环，返回到shell提示符下，需要使用break命令。

while :
do
    echo -n "1 to 5"
    read aNum
    case $aNum in
        1|2|3|4|5) echo "you input  $aNum!"
        ;;
        *) echo "not 1 to 5 game over"
        break
        ;;
    esac
done

#continue
#continue命令与break命令类似，
# 只有一点差别，它不会跳出所有循环，仅仅跳出当前循环。
while :
do
    echo -n "1 to 5 "
    read aNum
    case $aNum in
        1|2|3|4|5) echo "you input  $aNum!"
        ;;
        *) echo "you input not 1 to 5"
        continue
        echo "game over"
        ;;
    esac
done