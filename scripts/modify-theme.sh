#!/bin/bash
#=================================================
# File name: modify-theme.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: AIacg
# Blog: https://blog.aiacg.cn
#=================================================

pushd package/community

sed -i 's|content: "\e90d";|content: "{0}";|g' luci-theme-argon/htdocs/luci-static/argon/css/fonts.css
sed -i 's|content: "\e913";|content: "{1}";|g' luci-theme-argon/htdocs/luci-static/argon/css/fonts.css

sed -i 's|content: "{0}";|content: "\e913";|g' luci-theme-argon/htdocs/luci-static/argon/css/fonts.css
sed -i 's|content: "{1}";|content: "\e90d";|g' luci-theme-argon/htdocs/luci-static/argon/css/fonts.css

popd