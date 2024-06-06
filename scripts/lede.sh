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

# 添加 xiangfeidexiaohuo 源
git clone --depth=1 https://github.com/xiangfeidexiaohuo/extra-ipk
cp -r ./extra-ipk/op-ddnsgo ./
cp -r ./extra-ipk/luci-app-iperf3-server ./
rm -rf extra-ipk

# 添加 Lienol 源
git clone --depth=1 https://github.com/Lienol/openwrt-package
rm -rf ../../customfeeds/luci/applications/luci-app-kodexplorer
rm -rf openwrt-package/verysync
rm -rf openwrt-package/luci-app-filebrowser
rm -rf openwrt-package/luci-app-verysync

# 添加 luci-app-filebrowser
git clone --depth=1 https://github.com/wangqn/luci-app-filebrowser luci-app-filebrowser

# 添加 h69k-fanctrl
git clone --depth=1 https://github.com/MyTol/h69k-fanctrl h69k-fanctrl

# 添加 luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2
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
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff

# 添加 luci-theme
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
rm -rf ../../customfeeds/luci/themes/luci-theme-argon
rm -rf ../../customfeeds/luci/themes/luci-theme-argon-mod
rm -rf ./luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
cp -f $GITHUB_WORKSPACE/data/background.jpg luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
git clone https://github.com/DHDAXCW/theme
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
rm -rf package/wwan/rooter/0optionalapps/ext-rspeedtest
rm -rf package/wwan/rooter/0optionalapps/bwallocate
# 修改接口名
sed -i 's/wwan_5g_${modem_no}/wwan/g' package/wwan/luci-app-modem/root/etc/init.d/modem
sed -i 's/wwan6_5g_${modem_no}/wwan6/g' package/wwan/luci-app-modem/root/etc/init.d/modem
sed -i 's/wwan_5g_${modem_no}/wwan/g' package/wwan/luci-app-modem/root/usr/share/modem/modem_network_task.sh
sed -i 's/wwan6_5g_${modem_no}/wwan6/g' package/wwan/luci-app-modem/root/usr/share/modem/modem_network_task.sh
# 修复 FM160-CN 电话号码获取
rm -rf package/wwan/luci-app-modem/root/usr/share/modem/fibocom.sh
cp -f $GITHUB_WORKSPACE/data/fibocom.sh package/wwan/luci-app-modem/root/usr/share/modem/fibocom.sh
# 修改页面布局
rm -rf package/wwan/luci-app-modem/luasrc/view/modem/modem_info.htm
cp -f $GITHUB_WORKSPACE/data/modem_info.htm package/wwan/luci-app-modem/luasrc/view/modem/modem_info.htm
rm -rf package/wwan/luci-app-modem/luasrc/controller/modem.lua
cp -f $GITHUB_WORKSPACE/data/modem.lua package/wwan/luci-app-modem/luasrc/controller/modem.lua

# 修改本地化文本
## 基础
echo -e "\nmsgid \"Control\"" >> customfeeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "msgstr \"控制\"" >> customfeeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "\nmsgid \"NAS\"" >> customfeeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "msgstr \"存储\"" >> customfeeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "\nmsgid \"VPN\"" >> customfeeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "msgstr \"魔法\"" >> customfeeds/luci/modules/luci-base/po/zh-cn/base.po
## luci-app-modem
sed -i 's/msgstr "移动通信模组"/msgstr "移动通信"/g' package/wwan/luci-app-modem/po/zh-cn/modem.po
sed -i 's/msgstr "网络模式"/msgstr "网络模式(Network Mode)"/g' package/wwan/luci-app-modem/po/zh-cn/modem.po
## luci-app-turboacc
sed -i 's/Turbo ACC 网络加速设置/网络加速/g' customfeeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' customfeeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po
## luci-app-gowebdav 
sed -i 's/msgstr "GoWebDav"/msgstr "Webdav"/g' customfeeds/luci/applications/luci-app-gowebdav/po/zh_Hans/gowebdav.po
## luci-app-vsftpd
sed -i 's/msgstr "网络存储"/msgstr "存储"/g' customfeeds/luci/applications/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/msgstr "FTP 服务器"/msgstr "FTP"/g' customfeeds/luci/applications/luci-app-vsftpd/po/zh-cn/vsftpd.po
## luci-app-argon-config
sed -i 's/Argon 主题设置/主题设置/g' package/community/luci-app-argon-config/po/zh_Hans/argon-config.po
sed -i 's/Argon 主题设置/主题设置/g' customfeeds/luci/applications/luci-app-argon-config/po/zh_cn/argon-config.po
pushd customfeeds/luci/applications
ls
popd
## luci-app-filebrowser
sed -i 's/msgstr "文件浏览器"/msgstr "FileBrowser"/g' package/community/luci-app-filebrowser/po/zh-cn/filebrowser.po
## luci-app-iperf3-server
sed -i 's/msgstr "iPerf3 服务器"/msgstr "iPerf3"/g' package/community/luci-app-iperf3-server/po/zh-cn/iperf3-server.po

# 插件设置
#
## luci-app-oled
sed -i "s|enable '0'|enable '1'|g" customfeeds/luci/applications/luci-app-oled/root/etc/config/oled
sed -i "s|netspeed '0'|netspeed '1'|g" customfeeds/luci/applications/luci-app-oled/root/etc/config/oled
sed -i "s|time '60'|time '300'|g" customfeeds/luci/applications/luci-app-oled/root/etc/config/oled
sed -i "s|text 'OPENWRT'|text 'OmO'|g" customfeeds/luci/applications/luci-app-oled/root/etc/config/oled
sed -i "s|netsource 'eth0'|netsource 'wwan0'|g" customfeeds/luci/applications/luci-app-oled/root/etc/config/oled
### luci-app-filebrowser
sed -i 's|8088|8082|g' package/community/luci-app-filebrowser/root/etc/config/filebrowser
sed -i 's|/root|/home|g' package/community/luci-app-filebrowser/root/etc/config/filebrowser
sed -i 's|/tmp|/usr/bin|g' package/community/luci-app-filebrowser/root/etc/config/filebrowser
### luci-app-gowebdav
sed -i 's|6086|8083|g' customfeeds/packages/net/gowebdav/files/gowebdav.config
sed -i 's|user|OmO|g' customfeeds/packages/net/gowebdav/files/gowebdav.config
sed -i 's|pass|password|g' customfeeds/packages/net/gowebdav/files/gowebdav.config
sed -i 's|/mnt|/home|g' customfeeds/packages/net/gowebdav/files/gowebdav.config

# 修改默认 shell 为 zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd
## 设置主机名
sed -i 's/OpenWrt/OmO/g' package/base-files/files/bin/config_generate
# 修改默认 IP
# sed -i 's/192.168.1.1/192.168.11.1/g' package/base-files/files/bin/config_generate
# 设置 IPV6 分发长度
sed -i "s/ip6assign='60'/ip6assign='64'/g" package/base-files/files/bin/config_generate
