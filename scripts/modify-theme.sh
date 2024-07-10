#!/bin/bash
#=================================================
# File name: modify-theme.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: AIacg
# Blog: https://blog.aiacg.cn
#=================================================

pushd package/community/luci-theme-argon/htdocs/luci-static/argon/css/

sed -i 's|content: "\e90d";|content: "{0}";|g' fonts.css
sed -i 's|content: "\e915";|content: "{1}";|g' fonts.css


sed -i 's|content: "{0}";|content: "\e913";|g' fonts.css
sed -i 's|content: "{1}";|content: "\e90d";|g' fonts.css

popd