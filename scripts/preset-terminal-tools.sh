#!/bin/bash
#=================================================
# File name: preset-terminal-tools.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: SuLingGG
# Blog: https://mlapp.cn
#=================================================
mkdir -p files/root
pushd files/root

## 安装 oh-my-zsh
# Clone oh-my-zsh repository
git clone https://github.com/ohmyzsh/ohmyzsh ./.oh-my-zsh

# 安装扩展插件
git clone https://github.com/zsh-users/zsh-autosuggestions ./.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ./.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ./.oh-my-zsh/custom/plugins/zsh-completions

# 获取 .zshrc 文件
cp $GITHUB_WORKSPACE/scripts/.zshrc .

popd
