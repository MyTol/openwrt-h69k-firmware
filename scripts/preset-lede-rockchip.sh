#!/bin/bash
#=================================================
# File name: preset-lede-rockchip.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: AIacg
# Blog: https://blog.aiacg.cn
#=================================================

# 插件更改
#
## 调整 luci-app-modem
if [ "$MODIFY_MODEM" = "true" ]; then
  source $GITHUB_WORKSPACE/scripts/modify-modem.sh
fi
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
## 更改 Linux 核心版本为 6.1
sed -i 's/6.6/6.1/g' target/linux/rockchip/Makefile
## 修复 AutoCore 显示
sed -i 's/CPU: ${cpu_usage}/${cpu_usage}/g' package/lean/autocore/files/arm/sbin/usage
## 设置主机名
sed -i 's/OpenWrt/OmO/g' package/base-files/files/bin/config_generate
## 更改 Shell 为 zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd
## 设置 IPV6 分发长度
sed -i "s/ip6assign='60'/ip6assign='64'/g" package/base-files/files/bin/config_generate
## 更改菜单排序
source $GITHUB_WORKSPACE/scripts/modify-menu.sh
## 更改汉化文本
source $GITHUB_WORKSPACE/scripts/modify-localization.sh
# 修改 zzz-default-settings
pushd package/lean/default-settings/files
sed -i '/http/d' zzz-default-settings
sed -i '/18.06/d' zzz-default-settings
export orig_version=$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
export date_version=$(date -u +'%Y-%m-%d')
sed -i "s/${orig_version}/${orig_version}-D-(${date_version})/g" zzz-default-settings
popd