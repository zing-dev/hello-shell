#!/usr/bin/env bash

#cat 命令用于连接文件并打印到标准输出设备上。

#-n 或 --number：由 1 开始对所有输出的行数编号。
#-b 或 --number-nonblank：和 -n 相似，只不过对于空白行不编号。
#-s 或 --squeeze-blank：当遇到有连续两行以上的空白行，就代换为一行的空白行。
#-v 或 --show-nonprinting：使用 ^ 和 M- 符号，除了 LFD 和 TAB 之外。
#-E 或 --show-ends : 在每行结束处显示 $。
#-T 或 --show-tabs: 将 TAB 字符显示为 ^I。
#-e : 等价于 -vE。
#-A, --show-all：等价于 -vET。
#-e：等价于"-vE"选项；
#-t：等价于"-vT"选项；

cat -n -v cat.sh > cat.txt


cat -n -A cat.sh > cat.txt

cat -b cat.sh cat.txt >> cat
