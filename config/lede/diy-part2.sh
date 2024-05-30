#!/bin/bash
#=================================================
# 初始脚本 二
#=================================================

# 网络设置
#
## 设置 IPV4 地址
# sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
## 设置 IPV6 分发长度
sed -i "s/ip6assign='60'/ip6assign='64'/g" package/base-files/files/bin/config_generate
## 删除 IPV6 ULA 头
sed -i "s/ula_prefix='auto'/ula_prefix=''/g" package/base-files/files/bin/config_generate
## 设置主机名称
sed -i 's/OpenWrt/OmO/g' package/base-files/files/bin/config_generate
## 删除 Dropbear 接口
sed -i '/option Interface/d' package/network/services/dropbear/files/dropbear.config

# 主题设置
#
## 清理主题
rm -rf ./feeds/extraipk/theme/luci-theme-argon
rm -rf ./feeds/extraipk/theme/luci-app-argon-config
rm -rf ./feeds/luci/themes/luci-theme-argon
rm -rf ./feeds/luci/themes/luci-theme-design
rm -rf ./feeds/luci/themes/luci-theme-argon-mod
rm -rf ./package/feeds/extraipk/luci-theme-argon
rm -rf ./package/feeds/extraipk/luci-app-argon-config
rm -rf ./package/feeds/luci/luci-theme-argon
rm -rf ./package/feeds/luci/luci-theme-design
rm -rf ./package/feeds/luci/luci-theme-argon-mod
## 设置主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon-18.06/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon-18.06/g' feeds/luci/collections/luci-nginx/Makefile

# 汉化补充
#
## 基础
echo -e "\nmsgid \"Control\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "msgstr \"控制\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "\nmsgid \"NAS\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "msgstr \"存储\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "\nmsgid \"VPN\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "msgstr \"魔法\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
## 插件
### luci-app-idns
sed -i 's/内网域名服务/域名服务/g' feeds/extraipk/luci-app-idns/po/zh-cn/idns.po
### luci-app-turboacc
sed -i 's/Turbo ACC 网络加速设置/网络加速/g' feeds/extraipk/patch/luci-app-turboacc/po/zh-cn/turboacc.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' feeds/extraipk/patch/luci-app-turboacc/po/zh-cn/turboacc.po

# 插件设置
#
## 调整 luci-app-oled 监视接口
sed -i 's/eth0/wwan0/g' feeds/extraipk/luci-app-oled/root/etc/uci-defaults/oled
## 调整 luci-app-passwall 插件菜单入口
sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall/luasrc/passwall/*.lua
sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall/luasrc/model/cbi/passwall/client/*.lua
sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall/luasrc/model/cbi/passwall/server/*.lua
sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall/luasrc/view/passwall/app_update/*.htm
sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall/luasrc/view/passwall/socks_auto_switch/*.htm
sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall/luasrc/view/passwall/global/*.htm
sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall/luasrc/view/passwall/haproxy/*.htm
sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall/luasrc/view/passwall/log/*.htm
sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall/luasrc/view/passwall/node_list/*.htm
sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall/luasrc/view/passwall/rule/*.htm
sed -i 's/services/vpn/g' package/feeds/extraipk/luci-app-passwall/luasrc/view/passwall/server/*.htm

## 移动 RockChip 补丁
cp -af feeds/extraipk/patch/rockchip/* target/linux/rockchip/armv8/base-files/

## 调整 Golang 为 1.22.x
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang
