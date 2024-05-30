#!/bin/bash
#=================================================
# 初始脚本
#=================================================
## 移除 Lean 大佬的概览界面
rm -rf ./package/lean/autocore

## 添加叨叨插件库, 移动网络支持库
sed -i "1isrc-git extraipk https://github.com/xiangfeidexiaohuo/extra-ipk\n" feeds.conf.default
sed -i "2isrc-git wwan https://github.com/MyTol/5G-Modem-Support\n" feeds.conf.default

# 调整内核版本 5.15
sed -i "s/KERNEL_PATCHVER:=*.*/KERNEL_PATCHVER:=5.15/g" ./target/linux/rockchip/Makefile
sed -i "s/KERNEL_TESTING_PATCHVER:=*.*/KERNEL_TESTING_PATCHVER:=5.15/g" ./target/linux/rockchip/Makefile

## 更新软件源
./scripts/feeds update -a

# 拉取风扇降噪补丁
git clone --depth=1 https://github.com/MyTol/h69k-fanctrl package/h69k-fanctrl

# 拉取 MT7916 160Mhz 修复补丁
rm -rf package/kernel/mt76
git clone --depth=1 https://github.com/2253845067/mt76 package/kernel/mt76
