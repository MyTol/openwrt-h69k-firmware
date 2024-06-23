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

# 添加 xiangfeidexiaohuo 存储库
git clone --depth=1 https://github.com/xiangfeidexiaohuo/extra-ipk
cp -r ./extra-ipk/op-ddnsgo ./
cp -r ./extra-ipk/luci-app-iperf3-server ./
rm -rf extra-ipk

# 添加 Lienol 存储库
git clone --depth=1 https://github.com/Lienol/openwrt-package
rm -rf ../../feeds/luci/applications/luci-app-kodexplorer
rm -rf openwrt-package/verysync
rm -rf openwrt-package/luci-app-filebrowser
rm -rf openwrt-package/luci-app-verysync

# 添加 luci-app-filebrowser
#git clone --depth=1 https://github.com/wangqn/luci-app-filebrowser luci-app-filebrowser

# 添加 h69k-fanctrl
git clone --depth=1 https://github.com/2253845067/h69k-fanctrl h69k-fanctrl

# 添加 luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall

# 添加 luci-app-oled
rm -rf ../../feeds/luci/applications/luci-app-oled
git clone --depth=1 https://github.com/NateLol/luci-app-oled

# 添加 luci-app-poweroff
# git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff

# 添加 luci-theme
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-app-argon-config luci-app-argon-config
rm -rf ../../feeds/luci/themes/luci-theme-argon
rm -rf ../../feeds/luci/themes/luci-theme-argon-mod
rm -rf ./luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
cp -f $GITHUB_WORKSPACE/data/background.jpg luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
git clone --depth=1 https://github.com/DHDAXCW/theme
popd

# MT7916 160mhz 修复
#rm -rf package/kernel/mt76
#git clone --depth=1 https://github.com/2253845067/mt76 package/kernel/mt76

# 添加上游 5G 支持
rm -rf package/wwan
git clone --depth=1 https://github.com/Siriling/5G-Modem-Support package/wwan
# 修改接口名
sed -i 's/wwan_5g_${modem_no}/wwan_${modem_no}/g' package/wwan/luci-app-modem/root/etc/init.d/modem
sed -i 's/wwan6_5g_${modem_no}/wwan6_${modem_no}/g' package/wwan/luci-app-modem/root/etc/init.d/modem
sed -i 's/wwan_5g_${modem_no}/wwan_${modem_no}/g' package/wwan/luci-app-modem/root/usr/share/modem/modem_network_task.sh
sed -i 's/wwan6_5g_${modem_no}/wwan6_${modem_no}/g' package/wwan/luci-app-modem/root/usr/share/modem/modem_network_task.sh
# 修复 FM160-CN 电话号码获取
rm -rf package/wwan/luci-app-modem/root/usr/share/modem/fibocom.sh
cp -f $GITHUB_WORKSPACE/data/modem/fibocom.sh package/wwan/luci-app-modem/root/usr/share/modem/fibocom.sh
# 修改页面布局
rm -rf package/wwan/luci-app-modem/luasrc/view/modem/modem_info.htm
cp -f $GITHUB_WORKSPACE/data/view/modem_info.htm package/wwan/luci-app-modem/luasrc/view/modem/modem_info.htm
rm -rf package/wwan/luci-app-modem/luasrc/controller/modem.lua
cp -f $GITHUB_WORKSPACE/data/modem/modem.lua package/wwan/luci-app-modem/luasrc/controller/modem.lua

# 调整 luci-app-passwall 菜单入口
sed -i 's/services/vpn/g' package/community/openwrt-passwall/luci-app-passwall/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/community/openwrt-passwall/luci-app-passwall/luasrc/passwall/*.lua
sed -i 's/services/vpn/g' package/community/openwrt-passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/*.lua
sed -i 's/services/vpn/g' package/community/openwrt-passwall/luci-app-passwall/luasrc/model/cbi/passwall/server/*.lua
sed -i 's/services/vpn/g' package/community/openwrt-passwall/luci-app-passwall/luasrc/view/passwall/app_update/*.htm
sed -i 's/services/vpn/g' package/community/openwrt-passwall/luci-app-passwall/luasrc/view/passwall/socks_auto_switch/*.htm
sed -i 's/services/vpn/g' package/community/openwrt-passwall/luci-app-passwall/luasrc/view/passwall/global/*.htm
sed -i 's/services/vpn/g' package/community/openwrt-passwall/luci-app-passwall/luasrc/view/passwall/haproxy/*.htm
sed -i 's/services/vpn/g' package/community/openwrt-passwall/luci-app-passwall/luasrc/view/passwall/log/*.htm
sed -i 's/services/vpn/g' package/community/openwrt-passwall/luci-app-passwall/luasrc/view/passwall/node_list/*.htm
sed -i 's/services/vpn/g' package/community/openwrt-passwall/luci-app-passwall/luasrc/view/passwall/rule/*.htm
sed -i 's/services/vpn/g' package/community/openwrt-passwall/luci-app-passwall/luasrc/view/passwall/server/*.htm

# 调整 luci-app-fileassistant 菜单入口
#sed -i 's/nas/system/g' package/community/openwrt-package/luci-app-fileassistant/luasrc/controller/*.lua
#sed -i 's/, 1)/, 89)/g' package/community/openwrt-package/luci-app-fileassistant/luasrc/controller/*.lua
#sed -i 's/nas/system/g' package/community/openwrt-package/luci-app-fileassistant/htdocs/luci-static/resources/fileassistant/*.js

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
