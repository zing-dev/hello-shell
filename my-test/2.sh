#!/usr/bin/env bash

# 1.列出所有目录使用量，并按大小排序。
ls|xargs du -h|sort -rn 
#不递归下级目录使用du -
