#! /bin/bash

# 1) A Storm of Swords | George R. R. Martin, 1216 
# 2) The Two Towers | J. R. R. Tolkien, 352 
# 3) The Alchemist | Paulo Coelho, 197 
# 4) The Fellowship of the Ring | J. R. R. Tolkien, 432 
# 5) The Pilgrimage | Paulo Coelho, 288 
# 6) A Game of Thrones | George R. R. Martin, 864
sed 's/,/ |/' books.txt

# 1) A Storm of Swords |  George R. R. Martin |  1216 
# 2) The Two Towers |  J. R. R. Tolkien |  352 
# 3) The Alchemist |  Paulo Coelho |  197 
# 4) The Fellowship of the Ring |  J. R. R. Tolkien |  432 
# 5) The Pilgrimage |  Paulo Coelho |  288 
# 6) A Game of Thrones |  George R. R. Martin |  864
sed 's/,/ | /g' books.txt

# /home/vagrant/src/sed/sed-4.2.2/sed
echo "/bin/sed" | sed 's/\/bin\/sed/\/home\/vagrant\/src\/sed\/sed-4.2.2\/sed/'
echo "/bin/sed" | sed 's|/bin/sed|/home/vagrant/src/sed/sed-4.2.2/sed|'
echo "/bin/sed" | sed 's@/bin/sed@/home/vagrant/src/sed/sed-4.2.2/sed@'
echo "/bin/sed" | sed 's^/bin/sed^/home/vagrant/src/sed/sed-4.2.2/sed^'
echo "/bin/sed" | sed 's!/bin/sed!/home/vagrant/src/sed/sed-4.2.2/sed!'

# One Two Three
echo "Three One Two" | sed 's|\(\w\+\) \(\w\+\) \(\w\+\)|\2 \3 \1|'

echo -e "-------------------------正则表达式-------------------------"
# 标准正则表达式
# The Two Towers
# The Alchemist
# The Fellowship of the Ring
# The Pilgrimage
sed -n '/^The/ p' books2.txt

# Paulo Coelho
# Paulo Coelho
sed -n '/Coelho$/ p' books2.txt 

# cat
# bat
# rat
# mat
echo -e "cat\nbat\nrat\nmat\nbatting\nrats\nmats" | sed -n '/^..t$/p'

# Call
# Tall
echo -e "Call\nTall\nBall" | sed -n '/[CT]all/p'

# Ball
echo -e "Call\nTall\nBall" | sed -n '/[^CT]all/p'

# Call
# Tall
echo -e "Call\nTall\nBall" | sed -n '/[C-Z]all/ p' 

# \? ，\+ ，* 分别对应0次到1次，一次到多次，0次到多次匹配。
# {n} ，{n,} ，{m, n} 精确匹配N次，至少匹配N次，匹配M-N次
# | 或操作。
# str1
# str3
echo -e "str1\nstr2\nstr3\nstr4" | sed -n '/str\(1\|3\)/ p' 
# str2
# str3
echo -e "str1\nstr2\nstr3\nstr4" | sed -n '/str\(3\|2\)/ p' 

# Line	1
echo -e "Line\t1\nLine2" | sed -n '/Line\s/ p'

# \s匹配单个空白内容 \S匹配单个非空白内容。
# \w 单个单词、\W非单词

# 移除空行
echo -e "Line #1\n\n\nLine #2" | sed '/^$/d'

# 删除连续空行
echo -e "---"
# Line #1
# 
# Line #2
echo -e "Line #1\n\n\nLine #2" | sed '/./,/^$/!d'

echo -e "---"
# Line #1
# 
# Line #2
echo -e "\nLine #1\n\nLine #2" | sed '/./,$!d'

echo -e "---"
# 
# Line #1
# Line #2
echo -e "\nLine #1\nLine #2\n\n" | sed ':start /^\n*$/{$d; N; b start }'

echo -e '#include  
using namespace std; 
int main(void) 
{ 
   // Displays message on stdout. 
   cout >> "Hello, World !!!" >> endl;  
   return 0; // Return success. 
}' | sed 's|//.*||g'

# #include  
# using namespace std; 
# int main(void) 
# { 
#    
#    cout >> "Hello, World !!!" >> endl;  
#    return 0; 
# }

# 实现Wc -l命令
sed -n '$=' sed7.sh
wc -l sed7.sh

# 模拟实现head命令
head sed7.sh
sed '10 q' sed7.sh

# 模拟tail -1命令
tail -1 sed.sh
sed -n '$p' sed7.sh

# 模拟Dos2unix命令
echo -e '\n------------------------------------'
echo -e "Line #1\r\nLine #2\r" > test.txt
file test.txt
sed 's/^M$//' test.txt > new.txt
file new.txt
cat -vte new.txt
