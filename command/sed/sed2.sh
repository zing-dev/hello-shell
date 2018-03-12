#! /bin/bash

echo "1) A Storm of Swords, George R. R. Martin, 1216 
2) The Two Towers, J. R. R. Tolkien, 352 
3) The Alchemist, Paulo Coelho, 197 
4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
5) The Pilgrimage, Paulo Coelho, 288 
6) A Game of Thrones, George R. R. Martin, 864" > books.txt

# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '' books.txt

# 删除三行，-e选项指定三个独立的命令
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 6) A Game of Thrones, George R. R. Martin, 864
sed -e '1d' -e '2d' -e '5d' books.txt

# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
sed -n -e '1p' -e '2p' -e '3p' books.txt

echo -e "1d\n2d\n5d" > commands.txt 
# 1d
# 2d
# 5d
cat commands.txt
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 6) A Game of Thrones, George R. R. Martin, 864
sed -f commands.txt books.txt