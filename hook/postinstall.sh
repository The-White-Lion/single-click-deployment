#!/bin/bash

# Clean temp data
yellow "清理临时文件"
rm -rf "${TMP_DIR}"

# Environment Settings
blue "写入环境变量配置文件"
{
    echo "# Environment Settings"
    echo 'export PATH=".:$HOME/.bin:$HOME/.local/bin:$PATH"'

    # Proxy Settings
    echo "# Proxy Settings"
    if [[ "${os_type:0:3}" == "WSL" ]]; then
        echo 'proxy_ip=$(ip r | awk -F " "' "'"'NR == 1 {print $3}'"')"
        echo 'export http_proxy=http://$proxy_ip:7890'
        echo 'export https_proxy=http://$proxy_ip:7890'
    fi
} >> "${ENV_CONF}"

# Aliases Settings
blue "写入别名配置文件"
{
    echo 'alias python="python3"'
} >> "${ALIASES_CONF}"

yellow "zsh 配置完成"

yellow "请注销之后重新登陆，或者重启系统"
