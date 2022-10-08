#!/bin/bash

aliases_conf="$ZSH_DIR/aliases.zsh"
env_conf="$ZSH_DIR/env.zsh"
omz_conf="$ZSH_DIR/omz.zsh"
zshrc_conf="$ZSH_DIR/zshrc"


# oh-my-zsh path
omz_dir="$GITHUB_DIR/oh-my-zsh"

# Manual Installation
git clone https://github.com/ohmyzsh/ohmyzsh.git "$omz_dir"

# Theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${omz_dir}/custom/themes/powerlevel10k

# Plugin
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${omz_dir}/custom/plugins/zsh-syntax-highlighting

# Config profile
{
    echo "export ZSH=${omz_dir}"
    echo 'ZSH_THEME="powerlevel10k/powerlevel10k"'
    echo "plugins=(git zsh-syntax-highlighting vi-mode)"
    echo 'source $ZSH/oh-my-zsh.sh'
    echo -e '\n\n'
    echo '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh'
    echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh'
} > "$omz_conf"

[[ ! -f $aliases_conf ]] && touch $aliases_conf
[[ ! -f $env_conf ]] && touch $env_conf

{
    for f in "$ZSH_DIR"/*.zsh;
    do
        echo "source $f"
    done
} > "$zshrc_conf"

ln -s "$zshrc_conf" "$HOME/.zshrc"
chsh -s $(which zsh)
