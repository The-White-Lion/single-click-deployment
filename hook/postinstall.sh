#!/bin/bash

# Clean temp data
rm -rf $TMP_DIR

# Environment Settings
{
    echo "# Environment Settings"
    echo 'export PATH="$HOME/.bin:$HOME/.local/bin:$PATH:."'
} >> "$env_conf"

# Proxy Settings
{
    echo "# Proxy Settings"

    if [[ ${os_type:0:3} == "WSL" ]]; then
        echo 'proxy_ip=$(ip r | awk -F " "' "'"'NR == 1 {print $3}'"')"
        echo 'export http_proxy=http://$proxy_ip:7890'
        echo 'export https_proxy=http://$proxy_ip:7890'
    fi
} >> "$env_conf"

echo "环境变量配置完成"