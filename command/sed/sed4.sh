#! /bin/bash
# 模式空间

str="pig cow cow pig"
# 将一段文本中的pig替换成cow，并且将cow替换成horse：
# hores cow cow pig
echo ${str} | sed 's/pig/cow/;s/cow/hores/'
# hores hores hores hores
echo ${str} | sed 's/pig/cow/g;s/cow/hores/g'
# cow hores cow pig
echo ${str} | sed 's/cow/hores/;s/pig/cow/'
# cow hores hores cow
echo ${str} | sed 's/cow/hores/g;s/pig/cow/g'

# 地址匹配
list="Alice Ford, 22 East Broadway, Richmond VA
\nOrville Thomas, 11345 Oak Bridge Road, Tulsa OK
\nTerry Kalkas, 402 Lans Road, Beaver Falls PA
\nEric Adams, 20 Post Road, Sudbury MA
\nHubert Sims, 328A Brook Road, Roanoke VA
\nAmy Wilde, 334 Bayshore Pkwy, Mountain View CA
\nSal Carpenter, 73 6th Street, Boston MA"
#
echo -e ${list} | sed 'd'
# Orville Thomas, 11345 Oak Bridge Road, Tulsa OK 
# Eric Adams, 20 Post Road, Sudbury MA 
# Amy Wilde, 334 Bayshore Pkwy, Mountain View CA 
# Sal Carpenter, 73 6th Street, Boston MA
echo -e ${list} | sed '1d;3d;5d'

# 删除该范围内的所有行
# Alice Ford, 22 East Broadway, Richmond VA 
echo -e ${list} | sed '2,$d'

# 通过正则表达式来指定地址，删除包含MA VA的行：
# Orville Thomas, 11345 Oak Bridge Road, Tulsa OK 
# Terry Kalkas, 402 Lans Road, Beaver Falls PA 
# Amy Wilde, 334 Bayshore Pkwy, Mountain View CA 
echo -e ${list} | sed '/MA/d;/VA/d'

# Alice Ford, 22 East Broadway, Richmond ZING 
echo -e ${list} | sed '2,$d;s/VA/ZING/'

# 使用正则匹配，删除从包含Alice的行开始到包含Hubert的行结束的所有行
# Amy Wilde, 334 Bayshore Pkwy, Mountain View CA 
# Sal Carpenter, 73 6th Street, Boston MA
echo -e ${list} | sed '/Alice/,/Hubert/d'

# 行号和地址对是可以混用?
# Alice Ford, 22 East Broadway, Richmond VA
# Orville Thomas, 11345 Oak Bridge Road, Tulsa OK
echo -e ${list} | sed '3,$d' 
# Orville Thomas, 11345 Oak Bridge Road, Tulsa OK
echo -e ${list} | sed '3,$d;/VA/d'
# Alice Ford, 22 East Broadway, Richmond VA 
echo -e ${list} | sed '3,$d;2d' 
# Alice Ford, 22 East Broadway, Richmond VA
echo -e ${list} | sed '3,$d;2,/VA/d' 
# Orville Thomas, 11345 Oak Bridge Road, Tulsa OK
echo -e ${list} | sed '3,$d;2,/VA/!d' 

# Alice Ford, 22 East Broadway, Richmond VA
# Orville Thomas, 11345 Oak Bridge Road, Tulsa OK
# Terry Kalkas, 402 Lans Road, Beaver Falls, Pennsylvania
# Eric Adams, 20 Post Road, Sudbury, Massachusetts
echo -e ${list} | sed -n '1,4{s/ MA/, Massachusetts/;s/ PA/, Pennsylvania/;p}'