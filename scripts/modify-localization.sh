#!/bin/bash
#=================================================
# File name: modify-localization.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: AIacg
# Blog: https://blog.aiacg.cn
#=================================================

# 本地化文本
## 固件
echo -e "\nmsgid \"Control\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "msgstr \"控制\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "\nmsgid \"NAS\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "msgstr \"存储\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "\nmsgid \"VPN\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "msgstr \"魔法\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
sed -i 's|备份/升级|备份升级|g' feeds/luci/modules/luci-base/po/zh-cn/base.po
sed -i 's|备份/恢复|备份与恢复|g' feeds/luci/modules/luci-base/po/zh-cn/base.po
sed -i 's|DHCP/DNS|地址管理|g' feeds/luci/modules/luci-base/po/zh-cn/base.po

## 插件
### AutoCore
sed -i 's|CPU 使用率|核心占用|g' package/lean/default-settings/po/zh-cn/default.po
### luci-app-commands
sed -i 's|Custom Commands|Fast Commands|g' package/feeds/luci/luci-app-commands/po/zh-cn/commands.po
sed -i 's|自定义命令|快捷指令|g' package/feeds/luci/luci-app-commands/po/zh-cn/commands.po
### luci-app-arpbind
sed -i 's|IP/MAC 绑定|地址绑定|g' package/feeds/luci/luci-app-arpbind/po/zh-cn/arpbind.po
### luci-app-sqm
sed -i 's/msgstr "SQM QoS"/msgstr "智能队列"/g'  package/feeds/luci/luci-app-sqm/po/zh-cn/sqm.po
### luci-app-ttyd
sed -i 's/TTYD 终端/终端/g'  package/feeds/luci/luci-app-ttyd/po/zh-cn/terminal.po
### luci-app-nlbwmon
sed -i 's/带宽监控/流量/g' package/feeds/luci/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
### luci-app-wrtbwmon
sed -i 's/实时流量监测/实时/g' package/feeds/luci/luci-app-wrtbwmon/po/zh-cn/wrtbwmon.po
### luci-app-nfs
sed -i 's/NFS 管理/NFS/g' package/feeds/luci/luci-app-nfs/po/zh-cn/nfs.po
### luci-app-wol
sed -i 's/msgstr "网络唤醒"/msgstr "Wol"/g' package/feeds/luci/luci-app-wol/po/zh-cn/wol.po
### luci-app-turboacc
sed -i 's/Turbo ACC 网络加速设置/网络加速/g' package/feeds/luci/luci-app-turboacc/po/zh-cn/turboacc.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' package/feeds/luci/luci-app-turboacc/po/zh-cn/turboacc.po
### luci-app-vsftpd
sed -i 's/msgstr "网络存储"/msgstr "存储"/g' package/feeds/luci/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/msgstr "FTP 服务器"/msgstr "FTP"/g' package/feeds/luci/luci-app-vsftpd/po/zh-cn/vsftpd.po
### luci-app-iperf3-server
sed -i 's/msgstr "iPerf3 服务器"/msgstr "iPerf3"/g' package/community/luci-app-iperf3-server/po/zh-cn/iperf3-server.po
### luci-app-dockerman
sed -i 's/msgstr "Docker"/msgstr "容器"/g' package/feeds/luci/luci-app-dockerman/po/zh-cn/dockerman.po
### luci-app-argon-config
sed -i 's/Argon 主题设置/主题设置/g' package/community/luci-app-argon-config/po/zh-cn/argon-config.po
### luci-app-store
sed -i 's/msgstr "iStore"/msgstr "商店"/g' package/feeds/istore/luci-app-store/src/po/zh-cn/iStore.po
### luci-app-gowebdav 
cp -r package/feeds/luci/luci-app-gowebdav/po/zh_Hans package/feeds/luci/luci-app-gowebdav/po/zh-cn
sed -i 's/msgstr "GoWebDav"/msgstr "WebDav"/g' package/feeds/luci/luci-app-gowebdav/po/zh-cn/gowebdav.po
### luci-app-modem
if [ "$MODIFY_MODEM" = "true" ]; then
  sed -i 's/msgstr "移动通信模组"/msgstr "通信模组"/g' package/wwan/app/luci-app-modem/po/zh-cn/modem.po
else
  sed -i 's/msgstr "移动通信模组"/msgstr "通信模组"/g' package/wwan/luci-app-modem/po/zh-cn/modem.po
fi