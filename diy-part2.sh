#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# 默认地址
# sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# 主题设置
sed -i 's/+luci-theme-bootstrap/+luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/+luci-theme-bootstrap/+luci-theme-argon/g' lede/feeds/luci/collections/luci-ssl-nginx/Makefile
sed -i 's/+luci-theme-bootstrap/+luci-theme-argon/g' lede/feeds/luci/collections/luci-ssl-openssl/Makefile

# 主机名称
sed -i 's/OpenWrt/OmO/g' package/base-files/files/bin/config_generate

# 版本信息
# sed -i 's/R24.5.1/R24.5.1/g' package/lean/default-settings/files/zzz-default-settings
# sed -i 's/OpenWrt/OmO/g' package/lean/default-settings/files/zzz-default-settings

# 编译信息
# sed -i '/<tr><td width="33%"><%:CPU usage (%)%><\/td><td id="cpuusage">-<\/td><\/tr>/a\<tr><td width="33%"><%:Compiler author%><\/td><td>OmO<\/td><\/tr><\/table>' package/lean/autocore/files/arm/index.htm
# sed -i '$a\\nmsgid "Compiler author"\nmsgstr "编译者"' feeds/luci/modules/luci-base/po/zh-cn/base.po

# 清理 IPV6 ULA 头
sed -i "s/ula_prefix='auto'/ula_prefix=''/" package/base-files/files/bin/config_generate
