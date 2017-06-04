#!/usr/bin/env bash


# NF NF, 字段数量
# NR 行数
awk '{print NR ,NF,$1 $2}' $1 $2

#每位员工的总薪酬
awk '{ printf("total pay for %s is $%.2f\n", $1, $2 * $3) }' $1

#每位员工的姓名与薪酬
awk '{ printf("%-8s $%6.2f\n", $1, $2 * $3) }' $1

echo -e "**********************************************"
#排序输出
awk '{ printf("%6.2f    %s\n", $2 * $3, $0) }' $1 | sort

echo -e "**********************************************"

#通过对比选择
#每小时赚5美元或更多的员工
awk '$2 > 5 {print}' $1
echo -e "**********************************************"
#通过计算选择
#总薪资超过50美元的员工的薪酬
awk '$2*$3 > 50 {printf("%-8s   $%1.2f  %d   %3.2f \n",$1,$2,$3,$2*$3)}' $1
echo -e "**********************************************"

#通过文本内容选择
awk '$1 == "Mark2" { print }' $1
echo -e "**********************************************"

#模式组合
#括号和逻辑操作符与 && ， 或 || ， 以及非 ! 对模式进行组合
awk '$2>=4 || $3 >= 20 {print}' $1
echo -e "**********************************************"

awk 'NF != 3     { print $0, "number of fields is not equal to 3" }' $1
awk '$2 < 3.95   { print $0, "rate is below minimum wage" }' $1
awk '$2 > 10     { print $0, "rate exceeds $10 per hour" }' $1
awk '$3 < 0      { print $0, "negative hours worked" }' $1
awk '$3 > 60     { print $0, "too many hours worked" }' $1