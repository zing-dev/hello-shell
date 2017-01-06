#!/usr/bin/env bash

#Shell 传递参数

#$n。n 代表一个数字
name=$0
echo ${name}

#   $#	传递到脚本的参数个数
echo "argus "$#

#   $*	以一个单字符串显示所有向脚本传递的参数。
#   如"$*"用「"」括起来的情况、以"$1 $2 … $n"的形式输出所有参数。
echo '$* ' $*

#   $$	脚本运行的当前进程ID号
echo '$$ ' $$

#   $!	后台运行的最后一个进程的ID号
echo '$! '$!

#   $@	与$*相同，但是使用时加引号，并在引号中返回每个参数。
#   如"$@"用「"」括起来的情况、以"$1" "$2" … "$n" 的形式输出所有参数。
echo '$@' $@

#   $-	显示Shell使用的当前选项，与set命令功能相同。
echo '$-' $-

#   $?	显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。
echo '$?' $?


#$* 与 $@ 区别：
#相同点：都是引用所有参数。
#不同点：只有在双引号中体现出来。
# 假设在脚本运行时写了三个参数 1、2、3，，
# 则 " * " 等价于 "1 2 3"（传递了一个参数），
# 而 "@" 等价于 "1" "2" "3"（传递了三个参数）。
echo "-- \$* show ---"
for i in "$*"; do
    echo $i
done

echo "-- \$@ show ---"
for i in "$@"; do
    echo $i
done