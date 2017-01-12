#!/usr/bin/env bash

#command > file	将输出重定向到 file。
#command < file	将输入重定向到 file。
#command >> file	将输出以追加的方式重定向到 file。
#n > file	将文件描述符为 n 的文件重定向到 file。
#n >> file	将文件描述符为 n 的文件以追加的方式重定向到 file。
#n >& m	将输出文件 m 和 n 合并。
#n <& m	将输入文件 m 和 n 合并。
#<< tag	将开始标记 tag 和结束标记 tag 之间的内容作为输入。

#需要注意的是文件描述符 0 通常是标准输入（STDIN），
#1 是标准输出（STDOUT），2 是标准错误输出（STDERR）。

#输出重定向
#重定向一般通过在命令间插入特定的符号来实现。特别的，这些符号的语法如下所示:
#command1 > file1
whoami > whoami
echo "zhangrxiang like hly" > whoami
cat whoami
ls > whoami
cat whoami

date  >> whoami

echo "------------------------------------"
wc -l whoami

wc -l < whoami

#一般情况下，每个 Unix/Linux 命令运行时都会打开三个文件：
#标准输入文件(stdin)：stdin的文件描述符为0，Unix程序默认从stdin读取数据。
#标准输出文件(stdout)：stdout 的文件描述符为1，Unix程序默认向stdout输出数据。
#标准错误文件(stderr)：stderr的文件描述符为2，Unix程序会向stderr流中写入错误信息。
#默认情况下，command > file 将 stdout 重定向到 file，command < file 将stdin 重定向到 file。
#

echo "error" > err 2>&1

#Here Document
#Here Document 是 Shell 中的一种特殊的重定向方式，用来将输入重定向到一个交互式 Shell 脚本或程序。
#它的基本的形式如下：
#command << delimiter
#    document
delimiter
#它的作用是将两个 delimiter 之间的内容(document) 作为输入传递给 command。

wc -l << EOF
    Heel World
EOF


#/dev/null 文件
#如果希望执行某个命令，
# 但又不希望在屏幕上显示输出结果，那么可以将输出重定向到 /dev/null：

#$ command > /dev/null
#/dev/null 是一个特殊的文件，写入到它的内容都会被丢弃；如果尝试从该文件读取内容，那么什么也读不到。但是 /dev/null 文件非常有用，将命令的输出重定向到它，会起到"禁止输出"的效果。
#如果希望屏蔽 stdout 和 stderr，可以这样写：
#$ command > /dev/null 2>&1
#注意：0 是标准输入（STDIN），1 是标准输出（STDOUT），2 是标准错误输出（STDERR）。