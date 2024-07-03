#!/bin/bash
#=================================================
# File name: preset-golang.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: AIacg
# Blog: https://blog.aiacg.cn
#=================================================

# 删除 Golang 目录, 拉取新版代码.
rm -rf customfeeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 22.x customfeeds/packages/lang/golang