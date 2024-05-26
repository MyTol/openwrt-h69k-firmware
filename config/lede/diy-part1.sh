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

# 调整内核版本 5.15
sed -i "s/KERNEL_PATCHVER:=*.*/KERNEL_PATCHVER:=5.15/g" ./target/linux/rockchip/Makefile
sed -i "s/KERNEL_TESTING_PATCHVER:=*.*/KERNEL_TESTING_PATCHVER:=5.15/g" ./target/linux/rockchip/Makefile

# Small 大佬常用 OpenWrt 软件包 冲突处理
./scripts/feeds update -a
rm -rf feeds/luci/applications/luci-app-mosdns
# rm -rf feeds/packages/net/{alist,adguardhome,xray*,v2ray*,v2ray*,sing*,smartdns}
rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd-alt,miniupnpd-iptables,wireless-regdb,sms-tool,luci-app-sms-tool,filebrowser,luci-app-filebrowser,docker,dockerd}

# 添加 Turboacc
rm -rf feeds/luci/luci-app-turboacc
curl -sSL https://raw.githubusercontent.com/MyTol/turboacc/luci/add_turboacc.sh -o add_turboacc.sh
bash add_turboacc.sh

# 添加 5G 支持
rm -rf package/wwan
# git clone --depth=1 https://github.com/Siriling/5G-Modem-Support package/wwan
git clone --depth=1 https://github.com/MyTol/5G-Modem-Support package/wwan

# 降低风扇噪音
git clone --depth=1 https://github.com/MyTol/h69k-fanctrl package/h69k-fanctrl

# 风扇控制
# git clone --depth=1 https://github.com/hurrian/openwrt-alpine-fan-control

# 添加 MT7916 160Mhz 修复
rm -rf package/kernel/mt76
git clone --depth=1 https://github.com/2253845067/mt76 package/kernel/mt76

# 编译 luci-app-filebrowser 应用
git clone --depth=1 https://github.com/wangqn/luci-app-filebrowser package/luci-app-filebrowser

# 编译 luci-app-dockerman 应用
git clone --depth=1 https://github.com/WYC-2020/luci-app-dockerman package/luci-app-dockerman
