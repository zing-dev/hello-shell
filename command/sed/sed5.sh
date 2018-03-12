#! /bin/bash


sed '' books.txt

# 显示两次
sed 'p' books.txt
echo -e "\n"
sed -n 'p' books.txt
echo -e "\n"
# 3) The Alchemist, Paulo Coelho, 197 
sed -n '3p' books.txt
#2---5
sed -n '2,5 p' books.txt 
# 6) A Game of Thrones, George R. R. Martin, 864
sed -n '$ p' books.txt 
# 第三行到最后一行
sed -n '3,$ p' books.txt
# M, +n 将会打印出从第M行开始的下n行
sed -n '2,+4 p' books.txt
# M~N的形式，它告诉SED应该处理M行开始的每N行,50~5匹配行号50，55，60，65
# 奇数行
sed -n '1~2 p' books.txt 
# 偶数行
sed -n '2~2 p' books.txt 

echo '----------------'
#文本模式过滤器
# /pattern/comman
# 3) The Alchemist, Paulo Coelho, 197 
# 5) The Pilgrimage, Paulo Coelho, 288 
sed -n '/Paulo/ p' books.txt

# 第一次匹配到Alchemist开始输出，直到第5行为止。
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
sed -n '/Alchemist/, 5 p' books.txt

# 使用逗号（,）操作符指定匹配多个匹配的模式。下列的示例将会输出Two和Pilgrimage之间的所有行
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
sed -n '/Two/, /Pilgrimage/ p' books.txt 

# 第一次Two出现的位置开始输出接下来的4行
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed -n '/Two/, +4 p' books.txt

# 1) A Storm of Swords, George R. R. Martin, 1216 , 2) The Two Towers, J. R. R. Tolkien, 352 
# - 3) The Alchemist, Paulo Coelho, 197 , 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# - 5) The Pilgrimage, Paulo Coelho, 288 , 6) A Game of Thrones, George R. R. Martin, 864
sed -n 'h;n;H;x;s/\n/, /;/Paulo/!b Print; s/^/- /; :Print;p' books.txt

# 移除第四行
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '4d' books.txt 

# 移除N1到N2行
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '2, 4 d' books.txt   

# 除所有作者为Paulo Coelho的书籍
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '/Paulo Coelho/d' books.txt 

# 移除所有以Storm和Fellowship开头的行
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '/Storm/,/Fellowship/d' books.txt  

# 创建文件books.txt的副本，在 w 和 file 之间只能有一个空格
sed -n 'w books.bak' books.txt
#
diff books.txt books.bak
# 会存储文件中的偶数行到另一个文件
sed -n '2~2 w zing.txt' books.txt 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 6) A Game of Thrones, George R. R. Martin, 864
cat zing.txt 
# 存储所有独立作者的书到单独的文件
sed -n -e '/Martin/ w Martin.txt' -e '/Paulo/ w Paulo.txt' -e '/Tolkien/ w Tolkien.txt' books.txt  
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 6) A Game of Thrones, George R. R. Martin, 864
cat Martin.txt
# 3) The Alchemist, Paulo Coelho, 197 
# 5) The Pilgrimage, Paulo Coelho, 288 
cat Paulo.txt
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
cat Tolkien.txt

# 追加命令 a
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 7) Adultry, Paulo Coelho, 234
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
# 在第四行之后追加一本新书
sed '4 a 7) Adultry, Paulo Coelho, 234' books.txt

# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
# 7) Adultry, Paulo Coelho, 234
# 文件的结尾插入一行文本，使用 $ 作为地址
sed '$ a 7) Adultry, Paulo Coelho, 234' books.txt

# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 7) Adultry, Paulo Coelho, 234
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
# 在匹配 The Alchemist 的行之后追加文本
sed '/The Alchemist/ a 7) Adultry, Paulo Coelho, 234' books.txt  

# 行替换命令 c
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) Adultry, Paulo Coelho, 324
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
# 替换文本中的第三行为新的内容
sed '3 c 3) Adultry, Paulo Coelho, 324' books.txt

# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) Adultry, Paulo Coelho, 324
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '/The Alchemist/ c 3) Adultry, Paulo Coelho, 324' books.txt

# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 4) Adultry, Paulo Coelho, 324
sed '4, 6 c 4) Adultry, Paulo Coelho, 324' books.txt  

# 插入命令 i
echo -e "------------------插入命令 i----------------------"
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 7) Adultry, Paulo Coelho, 324
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
# 在第四行前插入新的一行
sed '4 i 7) Adultry, Paulo Coelho, 324' books.txt

echo -e "------------------转换命令 y----------------------"
# I V IV XX
echo "1 5 15 20" | sed 'y/151520/IVXVXX/'

echo -e "------------------输出隐藏字符命令 l----------------------"
sed 's/ /\t/g' books.txt > junk.txt
sed -n 'l' junk.txt
# 本按照指定的宽度换行
sed -n 'l 25' books.txt