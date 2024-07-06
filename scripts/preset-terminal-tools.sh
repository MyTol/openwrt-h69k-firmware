#!/bin/bash
#=================================================
# File name: preset-terminal-tools.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: SuLingGG
# Blog: https://mlapp.cn
#=================================================

## 安装 zhs 终端
#
##创建 files/root 目录
mkdir -p files/root
pushd files/root
## 拉取 oh-my-zsh 代码仓库
git clone https://github.com/ohmyzsh/ohmyzsh ./.oh-my-zsh
## 拉取 oh-my-zsh 插件仓库
git clone https://github.com/zsh-users/zsh-autosuggestions ./.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ./.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ./.oh-my-zsh/custom/plugins/zsh-completions
## 添加 .zshrc
cp $GITHUB_WORKSPACE/data/.zshrc .
popd
