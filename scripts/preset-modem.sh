#!/bin/bash
#=================================================
# File name: preset-modem.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: AIacg
# Blog: https://blog.aiacg.cn
#=================================================

## 调整创建的接口名
# sed -i 's/wwan_5g_${modem_no}/wwan_${modem_no}/g' package/wwan/app/luci-app-modem/root/etc/init.d/modem
# sed -i 's/wwan6_5g_${modem_no}/wwan6_${modem_no}/g' package/wwan/app/luci-app-modem/root/etc/init.d/modem
# sed -i 's/wwan_5g_${modem_no}/wwan_${modem_no}/g' package/wwan/app/luci-app-modem/root/usr/share/modem/modem_network_task.sh
# sed -i 's/wwan6_5g_${modem_no}/wwan6_${modem_no}/g' package/wwan/app/luci-app-modem/root/usr/share/modem/modem_network_task.sh
## 修复 FM160-CN 模块电话号码获取
rm -rf package/wwan/app/luci-app-modem/root/usr/share/modem/fibocom.sh
cp -f $GITHUB_WORKSPACE/data/modem/fibocom.sh package/wwan/app/luci-app-modem/root/usr/share/modem/fibocom.sh
## 替换静态页面
rm -rf package/wwan/app/luci-app-modem/luasrc/view/modem/modem_info.htm
cp -f $GITHUB_WORKSPACE/data/view/modem_info.htm package/wwan/app/luci-app-modem/luasrc/view/modem/modem_info.htm
rm -rf package/wwan/app/luci-app-modem/luasrc/controller/modem.lua
cp -f $GITHUB_WORKSPACE/data/modem/modem.lua package/wwan/app/luci-app-modem/luasrc/controller/modem.lua
## 调整本地化文本
sed -i 's/msgstr "网络模式"/msgstr "网络模式 (Network Mode)"/g' package/wwan/app/luci-app-modem/po/zh-cn/modem.po