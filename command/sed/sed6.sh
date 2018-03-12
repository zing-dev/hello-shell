#! /bin/bash

echo -e "---------------------退出命令 q------------------------"
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 退出命令 q
sed '3 q' books.txt

# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
sed '/The Alchemist/ q 100' books.txt
# 100
echo $?


echo -e "---------------------文件读取命令 r------------------------"
echo "This is junk text." > junk.txt 
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# This is junk text.
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '3 r junk.txt' books.txt 


echo -e "---------------------执行外部命令 e------------------------"
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# Mon Mar 12 10:25:13 CST 2018
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '3 e date' books.txt

# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# vagrant  pts/0        2018-03-12 08:59 (192.168.33.1)
# 3) The Alchemist, Paulo Coelho, 197 
# vagrant  pts/0        2018-03-12 08:59 (192.168.33.1)
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# vagrant  pts/0        2018-03-12 08:59 (192.168.33.1)
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '3,5 e who' books.txt

echo -e "date\ncal\nuname" > commands.txt
# Mon Mar 12 10:28:03 CST 2018
    #  March 2018       
# Su Mo Tu We Th Fr Sa  
            #  1  2  3  
#  4  5  6  7  8  9 10  
# 11 12 13 14 15 16 17  
# 18 19 20 21 22 23 24  
# 25 26 27 28 29 30 31  
                    #   
# Linux
sed 'e' commands.txt

echo -e "---------------------排除命令 !------------------------"
# 3) The Alchemist, Paulo Coelho, 197 
# 5) The Pilgrimage, Paulo Coelho, 288 
sed -n '/Paulo/p' books.txt
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 6) A Game of Thrones, George R. R. Martin, 864
sed -n '/Paulo/!p' books.txt

# 6) A Game of Thrones, George R. R. Martin, 864
# 5) The Pilgrimage, Paulo Coelho, 288 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 3) The Alchemist, Paulo Coelho, 197 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 1) A Storm of Swords, George R. R. Martin, 1216 
sed -n '1!G; h; $p' books.txt

echo -e "---------------------多行命令------------------------"
# N – 加载下一行
# A Storm of Swords,George R. R. Martin
# The Two Towers,J. R. R. Tolkien
# The Alchemist,Paulo Coelho
# The Fellowship of the Ring,J. R. R. Tolkien
# The Pilgrimage,Paulo Coelho
# A Game of Thrones,George R. R. Martin
sed 'N; s/\n/,/g' books2.txt

# D – 删除多行中的一行
# 删除到换行符（含 换行符）为止的所有字符
echo -e '\nThis is the header line.\nThis is a data line.\n\nThis is the last line.' | sed '/^$/{N; /header/D}'

# A Storm of Swords
# The Two Towers
# The Alchemist
# The Fellowship of the Ring
# The Pilgrimage
# A Game of Thrones
sed -n 'N;P' books2.txt

# sed (GNU sed) 4.2.2
sed --version
sed 'v 4.2.3' books.txt
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed 'v 4.2.2' books.txt

# 1
# A Storm of Swords
# 2
# George R. R. Martin
# 3
# The Two Towers
# 4
# J. R. R. Tolkien
# 5
# The Alchemist
# 6
# Paulo Coelho
# 7
# The Fellowship of the Ring
# 8
# J. R. R. Tolkien
# 9
# The Pilgrimage
# 10
# Paulo Coelho
# 11
# A Game of Thrones
# 12
# George R. R. Martin
# =命令用于输出行号
sed '=' books2.txt

# 1-4行输出行号
# 1
# A Storm of Swords
# 2
# George R. R. Martin
# 3
# The Two Towers
# 4
# J. R. R. Tolkien
# The Alchemist
# Paulo Coelho
# The Fellowship of the Ring
# J. R. R. Tolkien
# The Pilgrimage
# Paulo Coelho
# A Game of Thrones
# George R. R. Martin
sed '1, 4=' books2.txt

# A Storm of Swords
# George R. R. Martin
# The Two Towers
# J. R. R. Tolkien
# The Alchemist
# 6
# Paulo Coelho
# The Fellowship of the Ring
# J. R. R. Tolkien
# The Pilgrimage
# 10
# Paulo Coelho
# A Game of Thrones
# George R. R. Martin
sed '/Paulo/ =' books2.txt

# 12
sed -n '$ =' books2.txt

# &用于存储匹配模式的内容，通常与替换命令s一起使用
# Book number 1) A Storm of Swords, George R. R. Martin, 1216 
# Book number 2) The Two Towers, J. R. R. Tolkien, 352 
# Book number 3) The Alchemist, Paulo Coelho, 197 
# Book number 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# Book number 5) The Pilgrimage, Paulo Coelho, 288 
# Book number 6) A Game of Thrones, George R. R. Martin, 864
sed 's/[[:digit:]]/Book number &/' books.txt

# 匹配最后一个数字，并修改为Pages =。其中[[:digit:]]* *$：匹配0个或多个数字+0个或多个空格+行尾。
# 1) A Storm of Swords, George R. R. Martin, Pages = 1216 
# 2) The Two Towers, J. R. R. Tolkien, Pages = 352 
# 3) The Alchemist, Paulo Coelho, Pages = 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, Pages = 432 
# 5) The Pilgrimage, Paulo Coelho, Pages = 288 
# 6) A Game of Thrones, George R. R. Martin, Pages = 864
sed 's/[[:digit:]]* *$/Pages = &/' books.txt