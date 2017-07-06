#!/usr/bin/env bash

#名称	命令	语法	说明
#替换	s	[address]s/pattern/replacement/flags	替换匹配的内容
#删除	d	[address]d	删除匹配的行
#插入	i	[line-address]i\
#
#text	在匹配行的前方插入文本
#追加	a	[line-address]a\
#
#text	在匹配行的后方插入文本
#行替换	c	[address]c\
#
#text	将匹配的行替换成文本text
#打印行	p	[address]p	打印在模式空间中的行
#打印行号	=	[address]=	打印当前行行号
#打印行	l	[address]l	打印在模式空间中的行，同时显示控制字符
#转换字符	y	[address]y/SET1/SET2/	将SET1中出现的字符替换成SET2中对应位置的字符
#读取下一行	n	[address]n	将下一行的内容读取到
#读文件	r	[line-address]r file	将指定的文件读取到匹配行之后
#写文件	w	[address]w file	将匹配地址的所有行输出到指定的文件中
#退出	q	[line-address]q	读取到匹配的行之后即退出