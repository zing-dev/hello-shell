#! /bin/bash

########################-n#################################
# A world
# nihao
echo -e 'hello world\nnihao' | sed 's/hello/A/'

# -n选项后什么也没有显示
echo -e 'hello world\nnihao' | sed -n 's/hello/A/'

# -n选项后，再加p标记，只会把匹配并修改的内容打印了出来
# A world
echo -e 'hello world\nnihao' | sed -n 's/hello/A/p'
##########################################################

#########################-e################################
echo -e 'hello world' | sed -e 's/hello/A/' -e 's/world/B/'
echo -e 'hello world' | sed 's/hello/A/;s/world/B/'

#########################-i################################
echo "hello world" > file.txt
# hello world
cat file.txt
# A world
sed 's/hello/A/' file.txt
# hello world
cat file.txt

# A world
sed -i 's/hello/A/' file.txt
# A world
cat file.txt

echo "hello world" > file.txt
if [ -f file.txt.bak ];then
    rm file.txt.bak
fi
# file.txt  sed.sh
ls .
# 把修改内容保存到file.txt，同时会以file.txt.bak文件备份原来未修改文件内容，以确保原始文件内容安全性，防止错误操作而无法恢复原来内容。
sed -i.bak 's/hello/A/' file.txt
# file.txt  file.txt.bak	sed.sh
ls .
# A world
cat file.txt
# hello world
cat file.txt.bak

###########################-f##################################
echo "s/hello/A/
s/world/B/" > sed.script
# 多个子命令操作写入脚本文件，然后使用 -f 选项来指定该脚本
# A B
echo "hello world" | sed -f sed.script

###########################-r##################################
# sed命令的匹配模式支持正则表达式的，默认只能支持基本正则表达式，如果需要支持扩展正则表达式，那么需要添加-r选项。
#A A
echo "hello world" | sed -r 's/(hello)|(world)/A/g'

###############################################################
echo "There is only one thing that makes a dream impossible to achieve: the fear of failure. 
 - Paulo Coelho, The Alchemist" > quote.txt
# SED将会读取quote.txt文件中的一行内容存储到它的模式空间中，然后会在该缓冲区中执行SED命令。
# 没有提供SED命令，因此对该缓冲区没有要执行的操作，最后它会删除模式空间中的内容并且打印该内容到标准输出
sed '' quote.txt

# SED会从标准输入流接受输入
sed ''
