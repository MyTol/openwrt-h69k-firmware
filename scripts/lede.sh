#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: lede.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.

# 切换5.15内核编译
# sed -i 's/6.1/5.15/g' target/linux/rockchip/Makefile

# 添加 luci-app-modem
git clone --depth=1 https://github.com/Siriling/5G-Modem-Support package/wwan/modem

# 添加 luci-app-oled
#git clone --depth=1 https://github.com/NateLol/luci-app-oled feeds/luci/applications/luci-app-oled

# 添加风扇补丁
git clone --depth=1 https://github.com/2253845067/h69k-fanctrl package/h69k-fanctrl

# MT7916 160mhz 修复
#rm -rf package/kernel/mt76
#git clone --depth=1 https://github.com/2253845067/mt76 package/kernel/mt76
