#!/bin/bash
#=================================================
# File name: preset-localization.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: MyTol
# Blog: https://aiacg.cn
#=================================================

# 本地化文本
## 基础
echo -e "\nmsgid \"Control\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "msgstr \"控制\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "\nmsgid \"NAS\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "msgstr \"存储\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "\nmsgid \"VPN\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
echo -e "msgstr \"魔法\"" >> feeds/luci/modules/luci-base/po/zh-cn/base.po
sed -i 's|备份/升级|备份升级|g' feeds/luci/modules/luci-base/po/zh-cn/base.po
sed -i 's|备份/恢复|备份与恢复|g' feeds/luci/modules/luci-base/po/zh-cn/base.po
## 插件
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
### luci-app-modem
sed -i 's/msgstr "移动通信模组"/msgstr "移动通信"/g' package/wwan/luci-app-modem/po/zh-cn/modem.po
sed -i 's/msgstr "网络模式"/msgstr "网络模式 (Network Mode)"/g' package/wwan/luci-app-modem/po/zh-cn/modem.po
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

### luci-app-gowebdav 
pushd package/feeds/luci/luci-app-gowebdav/po
mkdir zh-cn
cp -f zh_Hans/gowebdav.po zh-cn/gowebdav.po
sed -i 's/msgstr "GoWebDav"/msgstr "WebDav"/g' zh-cn/gowebdav.po
popd

### luci-app-ipsec-server
#sed -i 's/IPSec VPN 服务器/IPSec/g' package/feeds/luci/luci-app-ipsec-server/po/zh-cn/ipsec-server.po
### luci-app-pptp-server
#sed -i 's/PPTP VPN 服务器/PPTP/g' package/feeds/luci/luci-app-pptp-server/po/zh-cn/pptp.po
### luci-app-nginx-manager
# sed -i 's/msgstr "Nginx管理器"/msgstr "Nginx"/g'  package/feeds/luci/luci-app-nginx-manager/po/zh-cn/nginx-manager.po
### luci-app-supervisord
# sed -i 's/msgstr "进程管理器"/msgstr "Supervisord"/g' package/feeds/luci/luci-app-supervisord/po/zh-cn/supervisord.po
### luci-app-store
sed -i 's/msgstr "iStore"/msgstr "商店"/g' package/feeds/istore/luci-app-store/src/po/zh-cn/iStore.po
### luci-app-filebrowser
#sed -i 's/msgstr "文件浏览器"/msgstr "FileBrowser"/g' package/community/luci-app-filebrowser/po/zh-cn/filebrowser.po