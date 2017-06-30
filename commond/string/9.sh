#!/usr/bin/env bash
a=aaaaaaaaaaa
b=${a:+bbbbbbbbbbb}
echo $b
a=${b:+${a}}
echo $a

#/d/phpStudy/WWW/learn-shell/commond/string
path=$(pwd)
echo $path
#/phpStudy/WWW/learn-shell/commond/string
echo ${path#/d}
#phpStudy/WWW/learn-shell/commond/string
echo ${path#/d/}
#string
echo ${path##/*/}
#/d/phpStudy/WWW/learn-shell/commond/
echo ${path%string}
#/d/phpStudy/WWW/learn-shell/commond/strin
echo ${path%%?}
#
echo ${path%%*}

#/d/phpStudy/WWW/learn-shell/commond/STRING
echo ${path/string/STRING}
#/D/phpStudy/WWW/learn-shell/commond/string
echo ${path/???//D/}
echo ${path/WWW/www}
#\d\phpStudy\WWW\learn-shell\commond\string
echo ${path//\//\\}

