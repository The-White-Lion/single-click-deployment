#!/bin/bash

set -u
source "utils/tools.sh"

omz_dir="${HOME}/.github/oh-my-zsh"
zshrc="${HOME}/.zshrc"

backup "${omz_dir}"
backup "${zshrc}"

# Oh My Zsh
git_clone "ohmyzsh/ohmyzsh.git" "${omz_dir}" "oh-my-zsh"

# Theme
zsh_theme="powerlevel10k/powerlevel10k"
git_clone "romkatv/powerlevel10k.git" "${omz_dir}/custom/themes/powerlevel10k" "${zsh_theme}"

# Plugin
plugins=("zsh-syntax-highlighting")
for plugin in ${plugins[*]}
do
    git_clone "zsh-users/${plugin}" "${omz_dir}/custom/plugins/zsh-syntax-highlighting" "{$plugin}"
done

# Config
[[ -d "${HOME}/.config/zsh" ]] || mkdir -p "${HOME}/.config/zsh"

{
    echo "export ZSH=${omz_dir}"
    echo "ZSH_THEME=\""${zsh_theme}"\""
    echo "plugins=(git ${plugins[*]} vi-mode)"
    echo 'source $ZSH/oh-my-zsh.sh'
    echo -e '\n'
    echo '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh'
    echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh'
} > "${HOME}/.config/zsh/omz.zsh"

cp "config/zsh/zshrc" "${HOME}/.config/zsh/zshrc"
ln -s "${HOME}/.config/zsh/zshrc" "${zshrc}"

sudo usermod -s "$(which zsh)" "${USER}"
