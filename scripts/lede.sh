#!/bin/bash
#=================================================
# File name: lede.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: AIacg
# Blog: https://blog.aiacg.cn
#=================================================

# 插件更改
#
## 修改 luci-app-modem 创建的接口名
#sed -i 's/wwan_5g_${modem_no}/wwan_${modem_no}/g' package/wwan/app/luci-app-modem/root/etc/init.d/modem
#sed -i 's/wwan6_5g_${modem_no}/wwan6_${modem_no}/g' package/wwan/app/luci-app-modem/root/etc/init.d/modem
#sed -i 's/wwan_5g_${modem_no}/wwan_${modem_no}/g' package/wwan/app/luci-app-modem/root/usr/share/modem/modem_network_task.sh
#sed -i 's/wwan6_5g_${modem_no}/wwan6_${modem_no}/g' package/wwan/app/luci-app-modem/root/usr/share/modem/modem_network_task.sh
## 修复 FM160-CN 模块电话号码获取
#rm -rf package/wwan/app/luci-app-modem/root/usr/share/modem/fibocom.sh
#cp -f $GITHUB_WORKSPACE/data/modem/fibocom.sh package/wwan/app/luci-app-modem/root/usr/share/modem/fibocom.sh
## 替换 luci-app-modem 静态页面
#rm -rf package/wwan/app/luci-app-modem/luasrc/view/modem/modem_info.htm
#cp -f $GITHUB_WORKSPACE/data/view/modem_info.htm package/wwan/app/luci-app-modem/luasrc/view/modem/modem_info.htm
#rm -rf package/wwan/app/luci-app-modem/luasrc/controller/modem.lua
#cp -f $GITHUB_WORKSPACE/data/modem/modem.lua package/wwan/app/luci-app-modem/luasrc/controller/modem.lua
## 调整 luci-app-passwall 菜单
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
## 调整 luci-app-gowebdav 设置
sed -i 's|6086|8083|g' customfeeds/packages/net/gowebdav/files/gowebdav.config
sed -i 's|user|OmO|g' customfeeds/packages/net/gowebdav/files/gowebdav.config
sed -i 's|pass|password|g' customfeeds/packages/net/gowebdav/files/gowebdav.config
sed -i 's|/mnt|/home|g' customfeeds/packages/net/gowebdav/files/gowebdav.config
## 替换 luci-theme-argon 默认背景
rm -rf package/community/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
cp -f $GITHUB_WORKSPACE/data/background.jpg package/community/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg

# 固件更改
#
# 添加 Linux Kernel 6.1 下 Gobinet 驱动补丁
pushd target/linux/generic/backport-6.1
cp -f $GITHUB_WORKSPACE/data/patch/6.1-872-export-some-functions-of-the-sched-module.patch ./
popd
## 修复 AutoCore 显示
cp -f $GITHUB_WORKSPACE/data/autocore/cpuinfo package/lean/autocore/files/arm/sbin/cpuinfo
sed -i 's/CPU: ${cpu_usage}/${cpu_usage}/g' package/lean/autocore/files/arm/sbin/usage
## 设置主机名
sed -i 's/OpenWrt/OmO/g' package/base-files/files/bin/config_generate
## 更改 Shell 为 zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd
## 设置 IPV6 分发长度
sed -i "s/ip6assign='60'/ip6assign='64'/g" package/base-files/files/bin/config_generate
## 安装 zsh 终端
source scripts/preset-terminal-tools.sh
## 更改 zzz-default-settings
pushd package/lean/default-settings/files
export orig_version=$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
export date_version=$(date -u +'%Y-%m-%d')
sed -i "s/${orig_version}/${orig_version} (${date_version})/g" zzz-default-settings
popd