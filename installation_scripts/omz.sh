#!/bin/bash

# Oh-My-Zsh Path
local omz_dir
omz_dir="${GITHUB_DIR}/oh-my-zsh"

# Manual Installation
git clone https://github.com/ohmyzsh/ohmyzsh.git "${omz_dir}"

if [[ $? != 0 ]]; then
    red "oh-my-zsh 下载失败，请退出程序检查网络连接"
    return 0
fi

# Theme
local zsh_theme
zsh_theme="powerlevel10k/powerlevel10k"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${omz_dir}/custom/themes/powerlevel10k"

if [[ $? != 0 ]]; then
    red "powerlevel10k 主题下载失败，切换为默认主题"
    zsh_theme="ys"
fi

# Plugin
local highlighting_plugin="zsh-syntax-highlighting"

git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${omz_dir}/custom/plugins/zsh-syntax-highlighting"

if [[ $? != 0 ]]; then
    red "命令行语法高亮插件，下载失败"
    zsh_theme=""
fi

# Config profile
{
    echo "export ZSH=${omz_dir}"
    echo "ZSH_THEME=\""${zsh_theme}"\""
    echo "plugins=(git ${highlighting_plugin} vi-mode)"
    echo 'source $ZSH/oh-my-zsh.sh'
    echo -e '\n'
    echo '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh'
    echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh'
} > "${OMZ_CONF}"

[[ ! -f "${ALIASES_CONF}" ]] && touch "${ALIASES_CONF}"
[[ ! -f "${ENV_CONF}" ]] && touch "${ENV_CONF}"

{
    local zsh_files="${ZSH_DIR}/*.zsh"
    for f in ${zsh_files}; do
        echo "source ${f}"
    done
} > "${ZSHRC_CONF}"

ln -s "${ZSHRC_CONF}" "${HOME}/.zshrc"
chsh -s "$(which zsh)"
