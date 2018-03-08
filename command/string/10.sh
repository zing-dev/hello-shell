#!/bin/bash

# 1. 取长度
str="abcd"
expr length $str   # 4
echo ${#str}       # 4
expr "$str" : ".*" # 4

echo ------------------------------------------------------------------
# 2. 查找子串的位置
str="abc"
expr index $str "a"  # 1
expr index $str "b"  # 2
expr index $str "x"  # 0
expr index $str ""   # 0

echo ------------------------------------------------------------------
# 3. 选取子串
str="abcdef"
expr substr "$str" 1 3  # 从第一个位置开始取3个字符， abc
expr substr "$str" 2 5  # 从第二个位置开始取5个字符， bcdef 
expr substr "$str" 4 5  # 从第四个位置开始取5个字符， def
 
echo ${str:2}           # 从第二个位置开始提取字符串， cdef
echo ${str:2:3}         # 从第二个位置开始提取3个字符, cde
echo ${str:(-6):5}        # 从倒数第二个位置向左提取字符串, abcde
echo ${str:(-4):3}      # 从倒数第二个位置向左提取6个字符, cde


echo ------------------------------------------------------------------

#  4.截取子串 
# 从位置position开始截取字符串
# 格式： ${str:position}

# 从start开始，截取长度为length的字符串
# 格式：${str:start:length}

# 从str开头开始删除substring匹配
# 格式：${str#substring}或${str##substring}

# 从str结尾开始删除substring匹配
# 格式：${str%substring}或${str%%substring}

str="abbc,def,ghi,abcjkl"
echo "1 -->"${str#a*c}     # 输出,def,ghi,abcjkl  一个井号(#) 表示从左边截取掉最短的匹配 (这里把abbc字串去掉）
echo "2 -->"${str##a*c}    # 输出jkl             两个井号(##) 表示从左边截取掉最长的匹配 (这里把abbc,def,ghi,abc字串去掉)
echo "3 -->"${str#"a*c"}   # 输出abbc,def,ghi,abcjkl 因为str中没有"a*c"子串
echo "4 -->"${str##"a*c"}  # 输出abbc,def,ghi,abcjkl 同理
echo "5 -->"${str#*a*c*}   # ,def,ghi,abcjkl
echo "6 -->"${str##*a*c*}  # 空
echo "7 -->"${str#d*f)}     # 输出abbc,def,ghi,abcjkl, 
echo "8 -->"${str#*d*f}    # 输出,ghi,abcjkl   
 
echo "9 -->"${str%a*l}     # abbc,def,ghi  一个百分号(%)表示从右边截取最短的匹配 
echo "10 -->"${str%%b*l}    # a             两个百分号表示(%%)表示从右边截取最长的匹配
echo "11 -->"${str%a*c}     # abbc,def,ghi,abcjkl


echo ------------------------------------------------------------------
# 5. 字符串替换 
# 用replace替换字符串中第一个substring
# 格式：${str/substring/replace}或者${str//substring/replace}

str="apple, tree, apple tree"
echo ${str/apple/APPLE}   # 替换第一次出现的apple   APPLE, tree, apple tree
echo ${str//apple/APPLE}  # 替换所有apple          APPLE, tree, APPLE tree
 
echo ${str/#apple/APPLE}  # 如果字符串str以apple开头，则用APPLE替换它         APPLE, tree, apple tree
echo ${str/%apple/APPLE}  # 如果字符串str以apple结尾，则用APPLE替换它         apple, tree, apple tree


# 6. 比较
[[ "a.txt" == a* ]]        # 逻辑真 (pattern matching)
[[ "a.txt" =~ .*\.txt ]]   # 逻辑真 (regex matching)
[[ "abc" == "abc" ]]       # 逻辑真 (string comparision) 
[[ "11" < "2" ]]           # 逻辑真 (string comparision), 按ascii值比较
 