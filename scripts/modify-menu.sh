#!/bin/bash
#=================================================
# File name: modify-menu.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: AIacg
# Blog: https://blog.aiacg.cn
#=================================================

## 调整菜单排序
#
##

## luci-app-store
sed -i 's|_("iStore"), 31|_("iStore"), 50|g' feeds/istore/luci/luci-app-store/luasrc/controller/store.lua

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
sed -i 's|_("Fast Commands"), 80|_("Fast Commands"), 55|g' luci/luci-app-commands/luasrc/controller/commands.lua
## luci-app-autoreboot
sed -i 's|_("Scheduled Reboot"),88|_("Scheduled Reboot"),60|g' luci/luci-app-autoreboot/luasrc/controller/autoreboot.lua
## luci-app-firewall
sed -i 's|_("Firewall"), 60|_("Firewall"), 25|g' luci/luci-app-firewall/luasrc/controller/firewall.lua
## luci-app-nlbwmon
sed -i 's|_("Bandwidth Monitor"), 80|_("Bandwidth Monitor"), 90|g' luci/luci-app-nlbwmon/luasrc/controller/nlbw.lua
## luci-app-sqm
sed -i 's|_("SQM QoS")|_("SQM QoS"), 40|g' luci/luci-app-sqm/luasrc/controller/sqm.lua
## luci-app-turboacc
sed -i 's|_("Turbo ACC Center"), 101|_("Turbo ACC Center"), 50|g' luci/luci-app-turboacc/luasrc/controller/turboacc.lua
## luci-app-zerotier
sed -i 's|, "VPN", 45|, "VPN", 60|g' luci/luci-app-zerotier/luasrc/controller/zerotier.lua
## luci-app-vsftpd
sed -i 's|, "NAS", 44|, _("NAS"), 70|g' luci/luci-app-vsftpd/luasrc/controller/vsftpd.lua
sed -i 's|_("FTP Server")|_("FTP Server"), 10|g' luci/luci-app-vsftpd/luasrc/controller/vsftpd.lua
## luci-app-rclone
sed -i 's|_("NAS") , 45|_("NAS"), 70|g' luci/luci-app-rclone/luasrc/controller/rclone.lua
sed -i 's|_("Rclone"), 100|_("Rclone"), 20|g' luci/luci-app-rclone/luasrc/controller/rclone.lua
## luci-app-gowebdav
sed -i 's|_("NAS"), 45|_("NAS"), 70|g' luci/luci-app-gowebdav/luasrc/controller/gowebdav.lua
sed -i 's|_("GoWebDav"), 100|_("GoWebDav"), 30|g' luci/luci-app-gowebdav/luasrc/controller/gowebdav.lua
## luci-app-wol
sed -i 's|_("Wake on LAN"), 90|_("Wake on LAN"), 5|g' luci/luci-app-wol/luasrc/controller/wol.lua
## luci-app-upnp
sed -i 's|_("UPnP")|_("UPnP"), 10|g' luci/luci-app-upnp/luasrc/controller/upnp.lua
## luci-app-smartdns
sed -i 's|_("SmartDNS"), 60|_("SmartDNS"), 25|g' luci/luci-app-smartdns/luasrc/controller/smartdns.lua
## luci-app-adguardhome
sed -i 's|_("AdGuard Home"), 10|_("AdGuard Home"), 35|g' luci/luci-app-adguardhome/luasrc/controller/AdGuardHome.lua
popd

pushd package/community
## luci-app-amlogic
sed -i 's|_("Amlogic Service"), 88|_("Amlogic Service"), 50|g' luci-app-amlogic/luasrc/controller/amlogic.lua
## luci-app-argon-config
sed -i 's|_("Argon Config"), 90|_("Argon Config"), 65|g' luci-app-argon-config/luasrc/controller/argon-config.lua
## luci-app-oled
sed -i 's|_("OLED"), 90|_("OLED"), 15|g' luci-app-oled/luasrc/controller/oled.lua
## luci-app-iperf3-server
sed -i 's|_("iPerf3 Server"),99|_("iPerf3 Server"), 20|g' luci-app-iperf3-server/luasrc/controller/iperf3-server.lua
## luci-app-ddns-go
sed -i 's|_("DDNS-GO"), 58|_("DDNS-GO"), 30|g' op-ddnsgo/luci-app-ddns-go/luasrc/controller/ddns-go.lua
popd

pushd package/wwan
## luci-app-modem
if [ "$MODIFY_MODEM" = "true" ]; then
  sed -i 's|translate("Modem"), 100|translate("Modem"), 45|g' app/luci-app-modem/luasrc/controller/modem.lua
else
  sed -i 's|translate("Modem"), 100|translate("Modem"), 45|g' luci-app-modem/luasrc/controller/modem.lua
fi
popd