#!/usr/bin/env bash

#-b：仅显示行中指定直接范围的内容；
#-c：仅显示行中指定范围的字符；
#-d：指定字段的分隔符，默认的字段分隔符为“TAB”；
#-f：显示指定字段的内容；
#-n：与“-b”选项连用，不分割多字节字符；
#--complement：补足被选择的字节、字符或字段；
#--out-delimiter=<字段分隔符>：指定输出内容是的字段分割符；
#--help：显示指令的帮助信息；
#--version：显示指令的版本信息。

cut -c 1-3 test.txt
cut -c 2-3 test.txt
cut -c 1 test.txt


cut -c 1-4 test.txt  > test2.txt