#!/bin/bash

aliases_conf="$zsh_dir/aliases.zsh"
env_conf="$zsh_dir/env.zsh"
omz_conf="$zsh_dir/omz.zsh"
zshrc_conf="$zsh_dir/zshrc"

{
    echo "source $aliases_conf"
    echo "source $env_conf"
    echo "source $omz_conf"
} >> "$zshrc_conf"

# oh-my-zsh config
omz_dir="$github_dir/oh-my-zsh"

git clone https://github.com/ohmyzsh/ohmyzsh.git "$omz_dir"

{
    echo "export ZSH=${omz_dir}"
    echo 'ZSH_THEME="ys"'
    echo "plugins=(git zsh-syntax-highlighting vi-mode)"
    echo 'source $ZSH/oh-my-zsh.sh'
} > "$omz_conf"

chsh -s $(which zsh)
