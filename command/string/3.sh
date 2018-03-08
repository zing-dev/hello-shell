#!/usr/bin/env bash

#用通配符*号代理strA中非strB的部分，如果结果相等说明包含，反之不包含。
A="helloworld"
B="low"
if [[ $A == *$B* ]]
then
    echo "包含"
else
    echo "不包含"
fi