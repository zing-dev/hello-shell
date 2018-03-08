#!/usr/bin/env bash

#=~ 直接判断strA是否包含strB
strA="helloworld"
strB="low"
strC="Llow"
if [[ ${strA} =~ $strB ]]
then
    echo "包含"
else
    echo "不包含"
fi

if [[ ${strA} =~ ${strC} ]]; then
    echo "exists"
fi