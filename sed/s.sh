#!/usr/bin/env bash

#替换	s	[address]s/pattern/replacement/flags	替换匹配的内容

#n: 一个数字（取值范围1-512），表明仅替换前n个被pattern匹配的内容；
#g: 表示全局替换，替换所有被pattern匹配的内容；
#p: 仅当行被pattern匹配时，打印模式空间的内容；
#w file：仅当行被pattern匹配时，将模式空间的内容输出到文件file中；

#[address]s/pattern/replacement/flags

#[address]是指地址，pattern是替换命令的匹配表达式，replacement则是对应的替换内容，flags是指替换的标志位


echo -e "****************************************************************"
#如果flags为空，则默认替换第一次匹配：
echo -e "column1 column2 column3 column4" | sed 's/ /;/'
echo -e "column1 column2 column3 column4" | sed 's/col/ /'
echo -e "****************************************************************"
#如果flags中包含g，则表示全局匹配：
echo -e "column1 column2 column3 column4" | sed 's/ /;/g'
echo -e "column1 column2 column3 column4" | sed 's/ /-/g'

echo -e "****************************************************************"
#如果flags中明确指定替换第n次的匹配，例如n=2：
echo -e "column1 column2 column3 column4" | sed 's/ /;/2'


echo -e "****************************************************************"

echo -e "testtest  text" | sed 's:test:TEXT:g'
echo -e "testtest  text" | sed 's,test,TEXT,g'
echo -e "testtest  text" | sed 's]test]TEXT]g'
which php
which php | sed 's/\/bin/\/usr\/local\/bin/g'

