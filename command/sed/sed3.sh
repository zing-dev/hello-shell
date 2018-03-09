#! /bin/bash

echo "A Storm of Swords
George R. R. Martin
The Two Towers
J. R. R. Tolkien
The Alchemist
Paulo Coelho
The Fellowship of the Ring
J. R. R. Tolkien
The Pilgrimage
Paulo Coelho
A Game of Thrones
George R. R. Martin" > books2.txt

#*************************************************
# A Storm of Swords, George R. R. Martin
# The Two Towers, J. R. R. Tolkien
# - The Alchemist, Paulo Coelho
# The Fellowship of the Ring, J. R. R. Tolkien
# - The Pilgrimage, Paulo Coelho
# A Game of Thrones, George R. R. Martin

sed -n '
h;n;H;x
s/\n/, /
/Paulo/!b Print
s/^/- /
:Print
p' books2.txt
# 第一行是h;n;H;x这几个命令，记得上面我们提到的 保持空间 吗？第一个h是指将当前模式空间中的内容覆盖到 保持空间中，n用于提前读取下一行，并且覆盖当前模式空间中的这一行，H将当前模式空间中的内容追加到 保持空间 中，最后的x用于交换模式空间和保持空间中的内容。因此这里就是指每次读取两行放到模式空间中交给下面的命令进行处理
# 接下来是 s/\n/, / 用于将上面的两行内容中的换行符替换为逗号
# 第三个命令在不匹配的时候跳转到Print标签，否则继续执行第四个命令
# :Print仅仅是一个标签名，而p则是print命令