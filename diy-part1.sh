#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
# echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
# echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# 添加 5G 支持
# git clone --depth=1 https://github.com/Siriling/5G-Modem-Support package/Modem-Support
git clone --depth=1 https://github.com/MyTol/5G-Modem-Support package/Modem-Support

# 添加风扇控制
# git clone --depth=1 https://github.com/2253845067/h69k-fanctrl package/h69k-fanctrl

# 添加 MT7916 160Mhz 修复
# rm -rf package/kernel/mt76
# git clone --depth=1 https://github.com/2253845067/mt76 package/kernel/mt76

# 编译 luci-app-filebrowser 应用
git clone --depth=1 https://github.com/wangqn/luci-app-filebrowser package/luci-app-filebrowser

# 编译 sendat 应用 -- luci-app-cpe 支持
# git clone --depth=1 https://github.com/ouyangzq/sendat package/sendat

# 编译 luci-app-cpe 应用
# git clone --depth=1 https://github.com/ouyangzq/luci-app-cpe package/luci-app-cpe
