#!/bin/bash

aliases_conf="$zsh_dir/aliases.zsh"
env_conf="$zsh_dir/env.zsh"
omz_conf="$zsh_dir/omz.zsh"
zshrc_conf="$zsh_dir/zshrc"


# oh-my-zsh config
omz_dir="$github_dir/oh-my-zsh"

# Manual Installation
git clone https://github.com/ohmyzsh/ohmyzsh.git "$omz_dir"

# Config profile
{
    echo "export ZSH=${omz_dir}"
    echo 'ZSH_THEME="ys"'
    echo "plugins=(git zsh-syntax-highlighting vi-mode)"
    echo 'source $ZSH/oh-my-zsh.sh'
} > "$omz_conf"

[[ ! -f $aliases_conf ]] && touch $aliases_conf
[[ ! -f $env_conf ]] && touch $env_conf

{
    for f in "$zsh_dir"/*.zsh;
    do
        echo "source $f"
    done
} >> "$zshrc_conf"

ln -s "$zshrc_conf" "$HOME/.zshrc"

chsh -s $(which zsh)
