#!/bin/bash
#=================================================
# 初始脚本 一
#=================================================

## 添加插件源
sed -i "1isrc-git extraipk https://github.com/MyTol/extra-ipk\n" feeds.conf.default

## 调整内核版本 5.15
sed -i "s/KERNEL_PATCHVER:=*.*/KERNEL_PATCHVER:=5.15/g" ./target/linux/rockchip/Makefile
sed -i "s/KERNEL_TESTING_PATCHVER:=*.*/KERNEL_TESTING_PATCHVER:=5.15/g" ./target/linux/rockchip/Makefile

## 更新软件源
./scripts/feeds update -a

## 拉取补丁
rm -rf package/wwan
rm -rf package/kernel/mt76
## 拉取 5G 补丁
git clone --depth=1 https://github.com/MyTol/5G-Modem-Support package/wwan
## 风扇降噪补丁
git clone --depth=1 https://github.com/MyTol/h69k-fanctrl package/utils/h69k-fanctrl
## 风扇强冷补丁
# cp -af feeds/extraipk/patch/rockchip/* target/linux/rockchip/armv8/base-files/
## 拉取 MT7916 160Mhz 补丁
git clone --depth=1 https://github.com/2253845067/mt76 package/kernel/mt76

## 移除冲突包
rm -rf package/lean/autocore
rm -rf package/feeds/extraipk/luci-app-wechatpush
rm -rf package/wwan/rooter/0optionalapps/bwallocate

## 拉取 luci-app-filebrowser 应用
git clone --depth=1 https://github.com/wangqn/luci-app-filebrowser feeds/luci/applications/luci-app-filebrowser

## 安装软件源
./scripts/feeds install -a
