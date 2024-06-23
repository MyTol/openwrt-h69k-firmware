#!/bin/bash
#=================================================
# File name: lean-rockchip.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: SuLingGG
# Blog: https://mlapp.cn
#=================================================

# 拉取存储库至 package/community 目录
mkdir package/community
pushd package/community

# 添加 xiangfeidexiaohuo 存储库
git clone --depth=1 https://github.com/xiangfeidexiaohuo/extra-ipk
cp -r ./extra-ipk/op-ddnsgo ./
cp -r ./extra-ipk/luci-app-iperf3-server ./
rm -rf extra-ipk

# 添加 jjm2473 存储库
# git clone --depth=1 https://github.com/jjm2473/openwrt-apps jjm2473
# rm -rf jjm2473/luci-app-cpufreq
# rm -rf jjm2473/luci-app-tasks
# rm -rf jjm2473/luci-lib-mac-vendor

# 添加 sundaqiang 存储库
# git clone --depth=1 https://github.com/sundaqiang/openwrt-packages sundaqiang

# 添加 Lienol 存储库
git clone --depth=1 https://github.com/Lienol/openwrt-package
rm -rf ../../customfeeds/luci/applications/luci-app-kodexplorer
rm -rf openwrt-package/verysync
rm -rf openwrt-package/luci-app-filebrowser
rm -rf openwrt-package/luci-app-verysync

# 添加 luci-app-filebrowser
# git clone --depth=1 https://github.com/wangqn/luci-app-filebrowser luci-app-filebrowser

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

# 添加 luci-app-poweroff
# git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff

# 添加 luci-theme
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-app-argon-config luci-app-argon-config
rm -rf ../../customfeeds/luci/themes/luci-theme-argon
rm -rf ../../customfeeds/luci/themes/luci-theme-argon-mod
rm -rf ./luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
cp -f $GITHUB_WORKSPACE/data/background.jpg luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
git clone --depth=1 https://github.com/DHDAXCW/theme
popd

# 修改 zzz-default-settings
pushd package/lean/default-settings/files
sed -i '/http/d' zzz-default-settings
sed -i '/18.06/d' zzz-default-settings
export orig_version=$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
export date_version=$(date -u +'%Y-%m-%d')
sed -i "s/${orig_version}/${orig_version} (${date_version})/g" zzz-default-settings
popd

# 添加上游 5G 支持
rm -rf package/wwan
git clone --depth=1 https://github.com/Siriling/5G-Modem-Support package/wwan
rm -rf package/wwan/rooter/0optionalapps/bwallocate
rm -rf package/wwan/rooter/0optionalapps/ext-speedtest
rm -rf package/wwan/rooter/0optionalapps/ext-rspeedtest
# 修改接口名, 将移除多模块兼容
sed -i 's/wwan_5g_${modem_no}/wwan/g' package/wwan/luci-app-modem/root/etc/init.d/modem
sed -i 's/wwan6_5g_${modem_no}/wwan6/g' package/wwan/luci-app-modem/root/etc/init.d/modem
sed -i 's/wwan_5g_${modem_no}/wwan/g' package/wwan/luci-app-modem/root/usr/share/modem/modem_network_task.sh
sed -i 's/wwan6_5g_${modem_no}/wwan6/g' package/wwan/luci-app-modem/root/usr/share/modem/modem_network_task.sh
# 修复 FM160-CN 电话号码获取
rm -rf package/wwan/luci-app-modem/root/usr/share/modem/fibocom.sh
cp -f $GITHUB_WORKSPACE/data/modem/fibocom.sh package/wwan/luci-app-modem/root/usr/share/modem/fibocom.sh
# 修改页面布局
rm -rf package/wwan/luci-app-modem/luasrc/view/modem/modem_info.htm
cp -f $GITHUB_WORKSPACE/data/view/modem_info.htm package/wwan/luci-app-modem/luasrc/view/modem/modem_info.htm
rm -rf package/wwan/luci-app-modem/luasrc/controller/modem.lua
cp -f $GITHUB_WORKSPACE/data/modem/modem.lua package/wwan/luci-app-modem/luasrc/controller/modem.lua

# 调整 luci-app-fileassistant 菜单入口
sed -i 's/nas/system/g' package/community/openwrt-package/luci-app-fileassistant/luasrc/controller/*.lua
sed -i 's/, 1)/, 89)/g' package/community/openwrt-package/luci-app-fileassistant/luasrc/controller/*.lua
sed -i 's/nas/system/g' package/community/openwrt-package/luci-app-fileassistant/htdocs/luci-static/resources/fileassistant/*.js

# 移除 uhttpd uhttpd-mod-ubus
# sed -i 's/+uhttpd +uhttpd-mod-ubus //g' feeds/luci/collections/luci/Makefile

# 为插件添加 Nginx 支持,
mkdir -p package/base-files/files/etc/nginx
# 为插件添加反代路由
cp -r $GITHUB_WORKSPACE/data/nginx/conf.d package/base-files/files/etc/nginx
# Nginx 禁用 HTTPS 访问
cp -f $GITHUB_WORKSPACE/data/nginx/_nginx customfeeds/packages/net/nginx-util/files/nginx.config
cp -f $GITHUB_WORKSPACE/data/nginx/_nginx.conf package/base-files/files/etc/nginx/nginx.conf
## luci-app-ttyd 
sed -i "s|:7681|/terminal|g" customfeeds/luci/applications/luci-app-ttyd/luasrc/view/terminal/terminal.htm
## luci-app-netdata
sed -i 's|:<%=luci.model.uci.cursor():get("netdata", "netdata", "port") %>|/netdata|g' customfeeds/luci/applications/luci-app-netdata/luasrc/view/netdata/netdata.htm
## uwsgi
cp -f $GITHUB_WORKSPACE/data/uwsgi/luci-cgi_io.ini customfeeds/packages/net/uwsgi/files-luci-support/luci-cgi_io.ini

# 插件设置
#
## luci-app-oled
sed -i "s|enable '0'|enable '1'|g" customfeeds/luci/applications/luci-app-oled/root/etc/config/oled
sed -i "s|netspeed '0'|netspeed '1'|g" customfeeds/luci/applications/luci-app-oled/root/etc/config/oled
sed -i "s|time '60'|time '300'|g" customfeeds/luci/applications/luci-app-oled/root/etc/config/oled
sed -i "s|text 'OPENWRT'|text 'OmO~~'|g" customfeeds/luci/applications/luci-app-oled/root/etc/config/oled
sed -i "s|netsource 'eth0'|netsource 'wwan0'|g" customfeeds/luci/applications/luci-app-oled/root/etc/config/oled
## luci-app-filebrowser
# sed -i 's|8088|8082|g' package/community/luci-app-filebrowser/root/etc/config/filebrowser
# sed -i 's|/root|/home|g' package/community/luci-app-filebrowser/root/etc/config/filebrowser
# sed -i 's|/tmp|/usr/bin|g' package/community/luci-app-filebrowser/root/etc/config/filebrowser
## luci-app-gowebdav
sed -i 's|6086|8083|g' customfeeds/packages/net/gowebdav/files/gowebdav.config
sed -i 's|user|OmO|g' customfeeds/packages/net/gowebdav/files/gowebdav.config
sed -i 's|pass|password|g' customfeeds/packages/net/gowebdav/files/gowebdav.config
sed -i 's|/mnt|/home|g' customfeeds/packages/net/gowebdav/files/gowebdav.config

# 修改默认 shell 为 zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd
## 设置主机名
sed -i 's/OpenWrt/OmO/g' package/base-files/files/bin/config_generate
# 修改默认 IP
# sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
# 设置 IPV6 分发长度
sed -i "s/ip6assign='60'/ip6assign='64'/g" package/base-files/files/bin/config_generate
