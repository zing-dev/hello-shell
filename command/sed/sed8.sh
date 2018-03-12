#! /bin/bash

# 模拟tr命令
# abc
echo "ABC" | tr "ABC" "abc"
# abc
echo "ABC" | sed 'y/ABC/abc/'

# 模拟grep -v命令
# Line #2
# Line #3
echo -e "Line #1\nLine #2\nLine #3" | grep -v 'Line #1'
# Line #2
# Line #3
echo -e "Line #1\nLine #2\nLine #3" | sed -n '/Line #1/!p'

# echo -e "Line #1nnnnLine #2nnnLine #3" | cat -s
# echo -e "Line #1\n\n\n\nLine #2\n\n\nLine #3" | cat -s