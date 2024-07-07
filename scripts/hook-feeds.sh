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

# 拉取 packages 软件源
git clone --depth=1 https://github.com/DHDAXCW/packages customfeeds/packages

# 更新 golang 与 automake 版本, 仅 DHDAXCW 仓库需要
if echo "$FEEDS_CONF" | grep -q "DHDAXCW"; then
  rm -rf tools/automake
  rm -rf customfeeds/packages/lang/golang
  cp -r $GITHUB_WORKSPACE/data/automake tools/
  git clone https://github.com/sbwml/packages_lang_golang -b 22.x customfeeds/packages/lang/golang
fi

# 拉取 luci 软件源
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

# 创建  package/community 目录, 并拉取额外支持文件.
mkdir package/community
pushd package/community

# 添加 xiangfeidexiaohuo 存储库
git clone --depth=1 https://github.com/xiangfeidexiaohuo/extra-ipk
cp -r ./extra-ipk/op-ddnsgo .
cp -r ./extra-ipk/luci-app-iperf3-server .
rm -rf extra-ipk

# 添加 Lienol 存储库
git clone --depth=1 https://github.com/Lienol/openwrt-package
rm -rf ../../customfeeds/luci/applications/luci-app-kodexplorer
rm -rf openwrt-package/verysync
rm -rf openwrt-package/luci-app-filebrowser
rm -rf openwrt-package/luci-app-verysync

# 添加 xiaorouji 存储库
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall

# 添加 luci-app-oled 插件
rm -rf ../../customfeeds/luci/applications/luci-app-oled
git clone --depth=1 https://github.com/NateLol/luci-app-oled op-oled
cp -r ./op-oled/luci-app-oled .
rm -rf ./op-oled

# 添加 h69k-fanctrl 插件
git clone --depth=1 https://github.com/2253845067/h69k-fanctrl h69k-fanctrl

# 添加 luci-app-amlogic 插件
git clone --depth=1 https://github.com/ophub/luci-app-amlogic op-amlogic
cp -r op-amlogic/luci-app-amlogic .
rm -rf amlogic

# 添加 luci-theme
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-app-argon-config luci-app-argon-config
rm -rf ../../customfeeds/luci/themes/luci-theme-argon
rm -rf ../../customfeeds/luci/themes/luci-theme-argon-mod
rm -rf ../../customfeeds/luci/applications/luci-app-argon-config
git clone --depth=1 https://github.com/DHDAXCW/theme
popd

# 添加 5G 支持
if [ "$MODIFY_MODEM" = "true" ]; then
  rm -rf package/wwan
  git clone --depth=1 https://github.com/my-world-only-me/modem package/wwan
else
  rm -rf package/wwan
  git clone --depth=1 https://github.com/Siriling/5G-Modem-Support package/wwan
  rm -rf package/wwan/rooter
fi

# 替换 Lede 代码修复 Linux Kernel 6.1 下 MT7916 的支持, 仅 DHDAXCW 仓库需要
if echo "$FEEDS_CONF" | grep -q "DHDAXCW"; then
  rm -rf package/kernel/mt76
  git clone --depth=1 https://github.com/my-world-only-me/mt76 package/kernel/mt76
fi