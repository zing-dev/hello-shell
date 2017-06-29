#!/usr/bin/env bash

#表达式	含义
#${#string}	$string的长度
str1=123456789
echo ${str1}
echo length is ${#str1}
#
#${string:position}	在$string中, 从位置$position开始提取子串
#6789
echo ${str1:5}

#${string:position:length}	在$string中, 从位置$position开始提取长度为$length的子串
#67
echo ${str1:5:2}
#
#${string#substring}	从变量$string的开头, 删除最短匹配$substring的子串
str2='hello word and hello shell'
#word and hello shell
echo ${str2#hello}
#'hello word and hello shell'
echo ${str2}
#${string##substring}	从变量$string的开头, 删除最长匹配$substring的子串
#llo word and hello shell
echo ${str2##he}
#${string%substring}	从变量$string的结尾, 删除最短匹配$substring的子串
#hello word and hello
echo ${str2%shell}
echo ${str2%and}
#${string%%substring}	从变量$string的结尾, 删除最长匹配$substring的子串
echo ${str2%%and}
#
#${string/substring/replacement}	使用$replacement, 来代替第一个匹配的$substring
echo ${str2/hello/HELLO}
#${string//substring/replacement}	使用$replacement, 代替所有匹配的$substring
echo ${str2//hello/HELLO}
#${string/#substring/replacement}	如果$string的前缀匹配$substring,
# 那么就用$replacement来代替匹配到的$substring
echo ${str2/#hel/HEL}
#${string/%substring/replacement}	如果$string的后缀匹配$substring,
# 那么就用$replacement来代替匹配到的$substring
echo ${str2/%ell/ELL}
echo ${str2/%hello/HELLO}

