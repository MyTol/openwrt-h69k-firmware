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
git clone --depth=1 https://github.com/MyTol/h69k-fanctrl h69k-fanctrl

# 添加 luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages
# git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2
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
# 修改接口名
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
sed -i 's/+uhttpd +uhttpd-mod-ubus //g' feeds/luci/collections/luci/Makefile

# 为插件添加 Nginx 支持, 禁用 https 访问
mkdir -p package/base-files/files/etc/nginx
cp -r $GITHUB_WORKSPACE/data/nginx/conf.d package/base-files/files/etc/nginx
mkdir -p package/base-files/files/etc/config
cp -f $GITHUB_WORKSPACE/data/nginx/_nginx package/base-files/files/etc/config/nginx.tmp
cp -f $GITHUB_WORKSPACE/data/nginx/_nginx.conf package/base-files/files/etc/nginx/nginx.conf.tmp
## luci-app-ttyd 
sed -i "s|:7681|/terminal|g" customfeeds/luci/applications/luci-app-ttyd/luasrc/view/terminal/terminal.htm
## luci-app-netdata
sed -i 's|:<%=luci.model.uci.cursor():get("netdata", "netdata", "port") %>|/netdata|g' customfeeds/luci/applications/luci-app-netdata/luasrc/view/netdata/netdata.htm
## uwsgi
mkdir -p package/base-files/files/etc/uwsgi/vassals
cp -f $GITHUB_WORKSPACE/data/uwsgi/luci-cgi_io.ini package/base-files/files/etc/uwsgi/vassals/luci-cgi_io.ini.tmp

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
# sed -i 's|6086|8083|g' customfeeds/packages/net/gowebdav/files/gowebdav.config
# sed -i 's|user|OmO|g' customfeeds/packages/net/gowebdav/files/gowebdav.config
# sed -i 's|pass|password|g' customfeeds/packages/net/gowebdav/files/gowebdav.config
# sed -i 's|/mnt|/home|g' customfeeds/packages/net/gowebdav/files/gowebdav.config

# 修改本地化文本
## 基础
echo -e "\nmsgid \"Control\"" >> customfeeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "msgstr \"控制\"" >> customfeeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "\nmsgid \"NAS\"" >> customfeeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "msgstr \"存储\"" >> customfeeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "\nmsgid \"VPN\"" >> customfeeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "msgstr \"魔法\"" >> customfeeds/luci/modules/luci-base/po/zh-cn/base.po

## luci-app-arpbind
sed -i 's|IP/MAC 绑定|地址绑定|g' customfeeds/luci/applications/luci-app-arpbind/po/zh-cn/arpbind.po
## luci-app-sqm
sed -i 's/msgstr "SQM QoS"/msgstr "流量塑形"/g' customfeeds/luci/applications/luci-app-sqm/po/zh-cn/sqm.po
## luci-app-ttyd
sed -i 's/TTYD 终端/终端/g' customfeeds/luci/applications/luci-app-ttyd/po/zh-cn/terminal.po
## luci-app-nginx-manager
# sed -i 's/msgstr "Nginx管理器"/msgstr "Nginx"/g' package/community/sundaqiang/luci-app-nginx-manager/po/zh-cn/nginx-manager.po
## luci-app-supervisord
# sed -i 's/msgstr "进程管理器"/msgstr "Supervisord"/g' package/community/sundaqiang/luci-app-supervisord/po/zh-cn/supervisord.po
## luci-app-nlbwmon
sed -i 's/带宽监控/流量/g' customfeeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
# luci-app-wrtbwmon
sed -i 's/实时流量监测/实时/g' customfeeds/luci/applications/luci-app-wrtbwmon/po/zh-cn/wrtbwmon.po
## luci-app-ipsec-server
sed -i 's/IPSec VPN 服务器/IPSec/g' customfeeds/luci/applications/luci-app-ipsec-server/po/zh-cn/ipsec-server.po
## luci-app-pptp-server
sed -i 's/PPTP VPN 服务器/PPTP/g' customfeeds/luci/applications/luci-app-pptp-server/po/zh-cn/pptp.po
## luci-app-nfs
sed -i 's/NFS 管理/NFS/g' customfeeds/luci/applications/luci-app-nfs/po/zh-cn/nfs.po
## luci-app-wol
sed -i 's/msgstr "网络唤醒"/msgstr "Wol"/g' customfeeds/luci/applications/luci-app-wol/po/zh-cn/wol.po
## luci-app-modem
sed -i 's/msgstr "移动通信模组"/msgstr "移动通信"/g' package/wwan/luci-app-modem/po/zh-cn/modem.po
sed -i 's/msgstr "网络模式"/msgstr "网络模式 (Network Mode)"/g' package/wwan/luci-app-modem/po/zh-cn/modem.po
## luci-app-turboacc
sed -i 's/Turbo ACC 网络加速设置/网络加速/g' customfeeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' customfeeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po
## luci-app-vsftpd
sed -i 's/msgstr "网络存储"/msgstr "存储"/g' customfeeds/luci/applications/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/msgstr "FTP 服务器"/msgstr "FTP"/g' customfeeds/luci/applications/luci-app-vsftpd/po/zh-cn/vsftpd.po
## luci-app-filebrowser
# sed -i 's/msgstr "文件浏览器"/msgstr "FileBrowser"/g' package/community/luci-app-filebrowser/po/zh-cn/filebrowser.po
## luci-app-iperf3-server
sed -i 's/msgstr "iPerf3 服务器"/msgstr "iPerf3"/g' package/community/luci-app-iperf3-server/po/zh-cn/iperf3-server.po
## luci-app-store
sed -i 's/msgstr "iStore"/msgstr "商店"/g' feeds/istore/luci/luci-app-store/src/po/zh-cn/iStore.po
## luci-app-dockerman
sed -i 's/msgstr "Docker"/msgstr "容器"/g' customfeeds/luci/applications/luci-app-dockerman/po/zh-cn/dockerman.po
## luci-app-argon-config
sed -i 's/Argon 主题设置/主题设置/g' package/feeds/luci/luci-app-argon-config/po/zh-cn/argon-config.po

## luci-app-gowebdav 
pushd customfeeds/luci/applications/luci-app-gowebdav/po
mkdir zh-cn
cp -f zh_Hans/gowebdav.po zh-cn/gowebdav.po
sed -i 's/msgstr "GoWebDav"/msgstr "Webdav"/g' zh-cn/gowebdav.po
popd

# 修改默认 shell 为 zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd
## 设置主机名
sed -i 's/OpenWrt/OmO/g' package/base-files/files/bin/config_generate
# 修改默认 IP
# sed -i 's/192.168.1.1/192.168.11.1/g' package/base-files/files/bin/config_generate
# 设置 IPV6 分发长度
sed -i "s/ip6assign='60'/ip6assign='64'/g" package/base-files/files/bin/config_generate
