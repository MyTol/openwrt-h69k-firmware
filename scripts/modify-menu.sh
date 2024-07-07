#!/bin/bash
#=================================================
# File name: init.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: AIacg
# Blog: https://blog.aiacg.cn
#=================================================

## 调整菜单排序
#
##
pushd feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin
## luci-mod-admin-full
cp -f $GITHUB_WORKSPACE/data/modify_menu/index.lua .
cp -f $GITHUB_WORKSPACE/data/modify_menu/network.lua .
cp -f $GITHUB_WORKSPACE/data/modify_menu/system.lua .
popd

pushd package/feeds
## luci-app-ttyd
sed -i 's|_("TTYD Terminal"), 10|_("TTYD Terminal"), 2|g' luci/luci-app-ttyd/luasrc/controller/terminal.lua
## luci-app-diskman
sed -i 's|_("Disk Man"), 55|_("Disk Man"), 25|g' luci/luci-app-diskman/luasrc/controller/diskman.lua
## luci-app-filetransfer
sed -i 's|_("FileTransfer"), 89|_("FileTransfer"), 45|g' luci/luci-app-filetransfer/luasrc/controller/filetransfer.lua
## luci-app-commands
sed -i 's|_("Custom Commands"), 80|_("Custom Commands"), 55|g' luci/luci-app-commands/luasrc/controller/commands.lua
## luci-app-autoreboot
sed -i 's|_("Scheduled Reboot"),88|_("Scheduled Reboot"),60|g' luci/luci-app-autoreboot/luasrc/controller/autoreboot.lua
## luci-app-store
sed -i 's|_("iStore"), 31|_("iStore"), 40|g' istore/luci-app-istore/luasrc/controller/store.lua
## luci-app-firewall
sed -i 's|_("Firewall"), 60|_("Firewall"), 25|g' luci/luci-app-firewall/luasrc/controller/firewall.lua
## luci-app-nlbwmon
sed -i 's|_("Bandwidth Monitor"), 80|_("Bandwidth Monitor"), 90|g' luci/luci-app-nlbwmon/luasrc/controller/nlbw.lua
## luci-app-sqm
sed -i 's|_("SQM QoS")|_("SQM QoS"), 40|g' luci/luci-app-sqm/luasrc/controller/sqm.lua
## luci-app-turboacc
sed -i 's|_("Turbo ACC Center"), 101|_("Turbo ACC Center"), 50|g' luci/luci-app-turboacc/luasrc/controller/turboacc.lua
popd

popd package/community
## luci-app-amlogic
sed -i 's|_("Amlogic Service"), 88|_("Amlogic Service"), 50|g' luci-app-amlogic/luasrc/controller/amlogic.lua
## luci-app-argon-config
sed -i 's|_("Argon Config"), 90|_("Argon Config"), 65|g' luci-app-argon-config/luasrc/controller/argon-config.lua
## luci-app-modem
if [ "$MODIFY_MODEM" = "true" ]; then
  sed -i 's|translate("Modem"), 100|translate("Modem"), 45|g' package/wwan/app/luci-app-modem/luasrc/controller/modem.lua
else
  sed -i 's|translate("Modem"), 100|translate("Modem"), 45|g' package/wwan/luci-app-modem/luasrc/controller/modem.lua
fi
popd

popd package/wwan
## luci-app-modem
if [ "$MODIFY_MODEM" = "true" ]; then
  sed -i 's|translate("Modem"), 100|translate("Modem"), 45|g' app/luci-app-modem/luasrc/controller/modem.lua
else
  sed -i 's|translate("Modem"), 100|translate("Modem"), 45|g' luci-app-modem/luasrc/controller/modem.lua
fi
popd