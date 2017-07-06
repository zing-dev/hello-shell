#!/usr/bin/env bash

#计数
awk '$3 > 15 { emp = emp + 1 }
END     { print emp, "employees worked more than 15 hours" }' $1

echo -e "**************************************************************"

awk ' { emp = emp + 1 }
END     { print "all is " ,emp, "employees" }' $1

echo -e "**************************************************************"

#求和与平均值
awk ' END { print NR, "employees" } ' $1
echo -e "**************************************************************"

#使用 NR 来计算薪酬均值的程序
awk ' sum = sum + $2 * $3 END { print "average money is $"sum / NR }' $1

awk '{ pay = pay + $2 * $3 }
      END { print NR, "employees"
      print "total pay is", pay
      print "average pay is", pay/NR
    }' $1

echo -e "**************************************************************"
#处理文本
#时薪最高的员工
awk ' $2 > maxrate { maxrate = $2; maxemp = $1 }
     END { print "highest hourly rate:", maxrate, "for", maxemp } ' $1
#时薪最低的员工
awk '  $2 < min { min = $2; who = $1} END { print "lower is ",who," is ",min}' $1

#字符串连接
awk ' { names = names $1 " "}
END { print names }'  $1

#打印最后一个输入行
awk '   { last = $0 }
END { print last }' $1

echo -e "**************************************************************"
#内置函数
awk '{ print $1, length($1) }' $1

echo -e "**************************************************************"
#行、单词以及字符的计数
awk '{ nc = nc + length($0) + 1
      nw = nw + NF
    }
END { print NR, "lines,", nw, "words,", nc, "characters" }' $1