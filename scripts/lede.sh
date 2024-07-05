#!/bin/bash
#=================================================
# File name: lede.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: AIacg
# Blog: https://blog.aiacg.cn
#=================================================

# 修复 AutoCore 样式
sed -i 's/CPU: ${cpu_usage}/${cpu_usage}/g' package/lean/autocore/files/arm/sbin/usage

## 设置主机名
sed -i 's/OpenWrt/OmO/g' package/base-files/files/bin/config_generate

# 设置 IPV6 分发长度
sed -i "s/ip6assign='60'/ip6assign='64'/g" package/base-files/files/bin/config_generate

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
rm -rf ../../customfeeds/luci/applications/luci-app-kodexplorer
rm -rf openwrt-package/verysync
rm -rf openwrt-package/luci-app-filebrowser
rm -rf openwrt-package/luci-app-verysync

# 添加 luci-app-oled
rm -rf ../../feeds/luci/applications/luci-app-oled
git clone --depth=1 https://github.com/NateLol/luci-app-oled

# 添加 h69k-fanctrl
git clone --depth=1 https://github.com/2253845067/h69k-fanctrl h69k-fanctrl

# 添加 luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall

# 调整 luci-app-passwall 菜单入口
sed -i 's/services/vpn/g' openwrt-passwall/luci-app-passwall/luasrc/controller/*.lua
sed -i 's/services/vpn/g' openwrt-passwall/luci-app-passwall/luasrc/passwall/*.lua
sed -i 's/services/vpn/g' openwrt-passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/*.lua
sed -i 's/services/vpn/g' openwrt-passwall/luci-app-passwall/luasrc/model/cbi/passwall/server/*.lua
sed -i 's/services/vpn/g' openwrt-passwall/luci-app-passwall/luasrc/view/passwall/app_update/*.htm
sed -i 's/services/vpn/g' openwrt-passwall/luci-app-passwall/luasrc/view/passwall/socks_auto_switch/*.htm
sed -i 's/services/vpn/g' openwrt-passwall/luci-app-passwall/luasrc/view/passwall/global/*.htm
sed -i 's/services/vpn/g' openwrt-passwall/luci-app-passwall/luasrc/view/passwall/haproxy/*.htm
sed -i 's/services/vpn/g' openwrt-passwall/luci-app-passwall/luasrc/view/passwall/log/*.htm
sed -i 's/services/vpn/g' openwrt-passwall/luci-app-passwall/luasrc/view/passwall/node_list/*.htm
sed -i 's/services/vpn/g' openwrt-passwall/luci-app-passwall/luasrc/view/passwall/rule/*.htm
sed -i 's/services/vpn/g' openwrt-passwall/luci-app-passwall/luasrc/view/passwall/server/*.htm

# 添加 luci-theme
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-app-argon-config luci-app-argon-config
rm -rf ../../customfeeds/luci/themes/luci-theme-argon
rm -rf ../../customfeeds/luci/themes/luci-theme-argon-mod
rm -rf ../../customfeeds/luci/applications/luci-app-argon-config
rm -rf ./luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
cp -f $GITHUB_WORKSPACE/data/background.jpg luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
git clone --depth=1 https://github.com/DHDAXCW/theme
popd

# 添加 5G 支持
rm -rf package/wwan
git clone --depth=1 https://github.com/my-world-only-me/modem package/wwan

# 添加 Linux Kernel 6.1 下 Gobinet 驱动补丁
pushd target/linux/generic/backport-6.1
cp -f $GITHUB_WORKSPACE/data/patch/6.1-872-export-some-functions-of-the-sched-module.patch ./
popd

# 修改接口名
sed -i 's/wwan_5g_${modem_no}/wwan_${modem_no}/g' package/wwan/app/luci-app-modem/root/etc/init.d/modem
sed -i 's/wwan6_5g_${modem_no}/wwan6_${modem_no}/g' package/wwan/app/luci-app-modem/root/etc/init.d/modem
sed -i 's/wwan_5g_${modem_no}/wwan_${modem_no}/g' package/wwan/app/luci-app-modem/root/usr/share/modem/modem_network_task.sh
sed -i 's/wwan6_5g_${modem_no}/wwan6_${modem_no}/g' package/wwan/app/luci-app-modem/root/usr/share/modem/modem_network_task.sh
# 修复 FM160-CN 模块电话号码获取
rm -rf package/wwan/app/luci-app-modem/root/usr/share/modem/fibocom.sh
cp -f $GITHUB_WORKSPACE/data/modem/fibocom.sh package/wwan/app/luci-app-modem/root/usr/share/modem/fibocom.sh
# 替换静态页面
rm -rf package/wwan/app/luci-app-modem/luasrc/view/modem/modem_info.htm
cp -f $GITHUB_WORKSPACE/data/view/modem_info.htm package/wwan/app/luci-app-modem/luasrc/view/modem/modem_info.htm
rm -rf package/wwan/app/luci-app-modem/luasrc/controller/modem.lua
cp -f $GITHUB_WORKSPACE/data/modem/modem.lua package/wwan/app/luci-app-modem/luasrc/controller/modem.lua

# 插件设置
#
## luci-app-oled
pushd package/community/luci-app-oled/luci-app-oled
sed -i "s|enable '0'|enable '1'|g" root/etc/config/oled
sed -i "s|netspeed '0'|netspeed '1'|g" root/etc/config/oled
sed -i "s|'60'|time '300'|g" root/etc/config/oled
sed -i "s|'OPENWRT'|text 'OmO~~'|g" root/etc/config/oled
sed -i "s|'eth0'|'wwan0'|g" root/etc/config/oled
popd

## luci-app-gowebdav
sed -i 's|6086|8083|g' customfeeds/packages/net/gowebdav/files/gowebdav.config
sed -i 's|user|OmO|g' customfeeds/packages/net/gowebdav/files/gowebdav.config
sed -i 's|pass|password|g' customfeeds/packages/net/gowebdav/files/gowebdav.config
sed -i 's|/mnt|/home|g' customfeeds/packages/net/gowebdav/files/gowebdav.config

# 修改 zzz-default-settings
pushd package/lean/default-settings/files
sed -i '/http/d' zzz-default-settings
sed -i '/18.06/d' zzz-default-settings
export orig_version=$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
export date_version=$(date -u +'%Y-%m-%d')
sed -i "s/${orig_version}/${orig_version} (${date_version})/g" zzz-default-settings
popd

# 更新软件源
./scripts/feeds update -a

# 安装软件源
./scripts/feeds install -a