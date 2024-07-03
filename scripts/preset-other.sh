#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: preset-other.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# 插件设置
#
## luci-app-oled
pushd package/community/luci-app-oled/luci-app-oled
sed -i "s|enable '0'|enable '1'|g" root/etc/config/oled
sed -i "s|netspeed '0'|netspeed '1'|g" root/etc/config/oled
sed -i "s|time '60'|time '300'|g" root/etc/config/oled
sed -i "s|text 'OPENWRT'|text 'OmO~~'|g" root/etc/config/oled
sed -i "s|netsource 'eth0'|netsource 'wwan0'|g" root/etc/config/oled
popd
## luci-app-gowebdav
sed -i 's|6086|8083|g' feeds/packages/net/gowebdav/files/gowebdav.config
sed -i 's|user|OmO|g' feeds/packages/net/gowebdav/files/gowebdav.config
sed -i 's|pass|password|g' feeds/packages/net/gowebdav/files/gowebdav.config
sed -i 's|/mnt|/home|g' feeds/packages/net/gowebdav/files/gowebdav.config

# 修改默认地址
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# 修改默认主题
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 修改主机名称
sed -i 's/OpenWrt/OmO/g' package/base-files/files/bin/config_generate

# 设置 IPV6 分发长度
sed -i "s/ip6assign='60'/ip6assign='64'/g" package/base-files/files/bin/config_generate