#!/bin/bash
#=================================================
# File name: lean.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: SuLingGG
# Blog: https://mlapp.cn
#=================================================
# Clone community packages to package/community

mkdir package/community
pushd package/community

# 添加 Lienol 源
git clone --depth=1 https://github.com/Lienol/openwrt-package
rm -rf ../../customfeeds/luci/applications/luci-app-kodexplorer
rm -rf openwrt-package/verysync
rm -rf openwrt-package/luci-app-verysync

# 添加 h69k-fanctrl
git clone --depth=1 https://github.com/MyTol/h69k-fanctrl h69k-fanctrl

# 添加 luci-app-ssr-plus
# git clone --depth=1 https://github.com/fw876/helloworld

# 添加 luci-app-passwall
git clone --depth=1 https://github.com/MyTol/openwrt-passwall-packages
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall

# 添加 OpenClash
# git clone --depth=1 https://github.com/vernesong/OpenClash

# 添加 luci-app-poweroff
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff

# 添加 luci-theme
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
rm -rf ../../customfeeds/luci/themes/luci-theme-argon
rm -rf ../../customfeeds/luci/themes/luci-theme-argon-mod
rm -rf ./luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
cp -f $GITHUB_WORKSPACE/data/background.jpg luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
git clone https://github.com/DHDAXCW/theme

# 添加 subconverter
# git clone --depth=1 https://github.com/tindy2013/openwrt-subconverter

# alist
# git clone --depth=1 https://github.com/sbwml/luci-app-alist

# Add OpenAppFilter
# git clone --depth=1 https://github.com/destan19/OpenAppFilter

popd
 
# 修改 zzz-default-settings
pushd package/lean/default-settings/files
sed -i '/http/d' zzz-default-settings
sed -i '/18.06/d' zzz-default-settings
export orig_version=$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
export date_version=$(date -u +'%Y-%m-%d')
sed -i "s/${orig_version}/${orig_version} (${date_version})/g" zzz-default-settings
popd

# 修改默认 shell 为 zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# 修改默认 IP
# sed -i 's/192.168.1.1/192.168.11.1/g' package/base-files/files/bin/config_generate
