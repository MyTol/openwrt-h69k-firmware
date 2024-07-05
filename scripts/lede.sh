#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: lede.sh
# Description: Lede DIY
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.

# 拉取存储库至 package/community 目录
mkdir package/community
pushd package/community

# 添加 h69k-fanctrl
git clone --depth=1 https://github.com/2253845067/h69k-fanctrl h69k-fanctrl

popd

# 添加 5G 支持
rm -rf package/wwan
git clone --depth=1 https://github.com/my-world-only-me/modem package/wwan

# 修改 zzz-default-settings
pushd package/lean/default-settings/files
sed -i '/http/d' zzz-default-settings
sed -i '/18.06/d' zzz-default-settings
export orig_version=$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
export date_version=$(date -u +'%Y-%m-%d')
sed -i "s/${orig_version}/${orig_version} (${date_version})/g" zzz-default-settings
popd

# 切换5.15内核编译
# sed -i 's/6.1/5.15/g' target/linux/rockchip/Makefile
