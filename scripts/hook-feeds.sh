#!/bin/bash
#=================================================
# File name: hook-feeds.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: AIacg
# Blog: https://blog.aiacg.cn
#=================================================

# 创建 customfeeds 目录
mkdir customfeeds
# 拉取 packages
git clone --depth=1 https://github.com/DHDAXCW/packages customfeeds/packages
# 更新 golang
source ./preset-golang.sh
# 拉取 luci
git clone --depth=1 https://github.com/DHDAXCW/luci customfeeds/luci
# 设置为本地源
pushd customfeeds/packages
export packages_feed="$(pwd)"
popd
pushd customfeeds/luci
export luci_feed="$(pwd)"
popd
sed -i '/src-git packages/d' feeds.conf.default
echo "src-link packages $packages_feed" >> feeds.conf.default
sed -i '/src-git luci/d' feeds.conf.default
echo "src-link luci $luci_feed" >> feeds.conf.default
# 更新源
./scripts/feeds update -a
