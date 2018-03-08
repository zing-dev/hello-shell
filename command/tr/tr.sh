#! /bin/bash
str="hello world"
echo ${str}

# HELLO WORLD
echo ${str} | tr [:lower:] [:upper:]
# HELLO WORLD
echo ${str} | tr 'a-z' 'A-Z'

######################################################
# -c或——complerment：取代所有不属于第一字符集的字符
str="hello world"
echo ${str}
# AAllAAAAAlA
echo ${str} | tr -c 'll\n' 'A'
# hello-world
echo ${str} | tr -c 'a-z\n' '-'
# hello-world
echo ${str} | tr -C 'a-z\n' '-'
#####################################################
# -d或——delete：删除所有属于第一字符集的字符
str="hello world"
# hello world
echo ${str}
# helloworld
echo ${str} | tr -d ' '
# he wrd
echo ${str} | tr -d 'llo'
#####################################################
# -s或--squeeze-repeats：把连续重复的字符以单独一个字符表示
str="thissss is      a text linnnnnnne."
# thissss is a text linnnnnnne.
echo ${str}
# this is a text line.
echo ${str} | tr -s ' sn'

#####################################################
# -t或--truncate-set1：先删除第一字符集较第二字符集多出的字符。
str="hello world"
# hello world
echo ${str}
# heaao worad
echo ${str} | tr -t 'l' 'a'
# hello-world
echo ${str} | tr -t ' ' '-'

#####################################################
# 字符集补集，从输入文本中将不在补集中的所有字符删除：
#  1  2  3  4
echo aa.,a 1 b#$bb 2 c*/cc 3 ddd 4 | tr -d -c '0-9 \n'

# 使用tr做数字相加操作：
# 45
echo 1 2 3 4 5 6 7 8 9 | xargs -n1 | echo $[ $(tr '\n' '+') 0 ]

# 除Windows文件“造成”的'^M'字符：
# cat file | tr -s "\r" "\n" > new_file
# cat file | tr -d "\r" > new_file