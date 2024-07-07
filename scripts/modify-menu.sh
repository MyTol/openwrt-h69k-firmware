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
pushd /usr/lib/lua/luci/controller

if [ -f "terminal.lua" ]; then
  # 终端
  sed -i 's|_("TTYD Terminal"), 10|_("TTYD Terminal"), 2|g' terminal.lua
fi

if [ -f "admin/system.lua" ]; then
  # 重启
  sed -i 's|_("Reboot"), 90|_("Reboot"), 3|g' admin/system.lua
  # 管理权
  sed -i 's|_("Administration"), 2|_("Administration"), 5|g' admin/system.lua
  # 启动项
  sed -i 's|_("Startup"), 45|_("Startup"), 15|g' admin/system.lua
  # 挂载点
  sed -i 's|_("Mount Points"), 50|_("Mount Points"), 20|g' admin/system.lua
  # 计划任务
  sed -i 's|_("Scheduled Tasks"), 46|_("Scheduled Tasks"), 30|g' admin/system.lua
  # LED 配置
  sed -i 's|_("<abbr title=\"Light Emitting Diode\">LED</abbr> Configuration"), 60|_("<abbr title=\"Light Emitting Diode\">LED</abbr> Configuration"), 35|g' admin/system.lua
  # 备份升级
  sed -i 's|_("Backup / Flash Firmware"), 70|_("Backup / Flash Firmware"), 40|g' admin/system.lua
fi

if [ -f "diskman.lua" ]; then
  # 磁盘管理
  sed -i 's|_("Disk Man"), 55|_("Disk Man"), 25|g' diskman.lua
fi

if [ -f "filetransfer.lua" ]; then
  # 文件传输
  sed -i 's|_("FileTransfer"), 89|_("FileTransfer"), 45|g' filetransfer.lua
fi

if [ -f "amlogic.lua" ]; then
  # 晶晨宝盒
  sed -i 's|_("Amlogic Service"), 88|_("Amlogic Service"), 50|g' amlogic.lua
fi

if [ -f "commands.lua" ]; then
  # 快捷命令
  sed -i 's|_("Custom Commands"), 80|_("Custom Commands"), 55|g' commands.lua
fi

if [ -f "autoreboot.lua" ]; then
  # 定时重启
  sed -i 's|_("Scheduled Reboot"),88|_("Scheduled Reboot"),60|g' autoreboot.lua
fi

if [ -f "argon-config.lua" ]; then
  # 主题设置
  sed -i 's|_("Argon Config"), 90|_("Argon Config"), 65|g' argon-config.lua
fi

if [ -f "store.lua" ]; then
  # 商店
  sed -i 's|_("iStore"), 31|_("iStore"), 40|g' store.lua
fi

if [ -f "admin/index.lua" ]; then
  # 服务
  sed -i 's|_("Services"), 40|_("Services"), 50|g' admin/index.lua
  # 魔法
  sed -i 's|_("VPN"), 44|_("VPN"), 60|g' admin/index.lua
  # 存储
  sed -i 's|_("NAS"), 44|_("NAS"), 70|g' admin/index.lua
  # 退出
  sed -i 's|_("Logout"), 90|_("Logout"), 99|g' admin/index.lua
fi

if [ -f "admin/network.lua" ]; then
  # 网络
  sed -i '0,/page.order  = 50/s//page.order  = 80/' admin/network.lua
  # 主机名
  sed -i 's|page.order  = 40|page.order  = 20|g' admin/network.lua
  # 静态路由
  sed -i 's|page.order  = 50|page.order  = 35|g' admin/network.lua
  # 网络诊断
  sed -i 's|page.order  = 60|page.order  = 40|g' admin/network.lua
fi

if [ -f "firewall.lua" ]; then
  # 防火墙
  sed -i 's|_("Firewall"), 60|_("Firewall"), 25|g' firewall.lua
fi

if [ -f "nlbw.lua" ]; then
  # 流量
  sed -i 's|_("Bandwidth Monitor"), 80|_("Bandwidth Monitor"), 90|g' nlbw.lua
fi

popd

rm -rf /tmp/luci-indexcache
rm -rf /tmp/luci-modulecache/*