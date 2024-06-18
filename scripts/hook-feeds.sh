#!/bin/bash
# 创建 customfeeds 目录
mkdir customfeeds
# 拉取 packages
git clone --depth=1 https://github.com/DHDAXCW/packages customfeeds/packages
# 拉取新版 Golang
rm -rf customfeeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 22.x customfeeds/packages/lang/golang
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
