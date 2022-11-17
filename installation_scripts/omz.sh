#!/bin/bash

# Oh-My-Zsh Path
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
    echo -e '\n'
    echo '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh'
    echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh'
} > "$OMZ_CONF"

[[ ! -f $ALIASES_CONF ]] && touch $ALIASES_CONF
[[ ! -f $ENV_CONF ]] && touch $ENV_CONF

{
    for f in "$ZSH_DIR"/*.zsh;
    do
        echo "source $f"
    done
} > "$ZSHRC_CONF"

ln -s "$ZSHRC_CONF" "$HOME/.zshrc"
chsh -s $(which zsh)
