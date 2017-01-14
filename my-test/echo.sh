#!/usr/bin/env bash


#格式为 \e[背景色;前景色;高亮格式m

#背景色可以被以下数字替换
#0 透明（使用终端颜色）, 40 黑, 41 红, 42 绿, 43 黄, 44 蓝 45 紫, 46 青绿, 47白（灰）
#
#前景色（也就是文本的颜色）可以被以下数字替换
#30 黑 31 红, 32 绿, 33 黄, 34 蓝, 35 紫, 36 青绿, 37 白（灰）
#
#高亮是1，不高亮是0
#注意m后面紧跟字符串。
#\e[0;;m \e[0m
echo -e '\e[0;31;1mzhangrxianglikehoulingyan\e[0m'
echo -e '\e[0;33;1mHello\e[0m World'   # 带颜色的玩法
echo -e '\e[0;33;4mHello\e[0m World'   # 带颜色+下划线
echo -e '\e[0;33;5mHello\e[0m World'   # 带颜色+闪烁