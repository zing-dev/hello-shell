#!/usr/bin/env bash


#利用grep查找
strA="long string"
strB="string1"
result=$(echo $strA | grep "${strB}")
if [[ ${result} == ${strA} ]]; then
    echo "exists"
fi
if [[ "$result" != "" ]]
then
    echo "包含"
else
    echo "不包含"
fi
