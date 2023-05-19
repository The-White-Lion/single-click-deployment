#!/bin/bash

set -u

omz_dir="${HOME}/tmp/oh-my-zsh"

if [[ -d "${omz_dir}" ]]; then
 mv "${omz_dir}" "${omz_dir}$(date +'%Y%m%d%H%M%S')"
fi

git clone https://github.com/ohmyzsh/ohmyzsh.git "${omz_dir}"

if [[ $? != 0 ]]; then
  echo "oh-my-zsh 下载失败，请退出程序检查网络连接"
fi

# theme
zsh_theme="powerlevel10k/powerlevel10k"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${omz_dir}/custom/themes/powerlevel10k"

if [[ $? != 0 ]]; then
  echo "powerlevel10k 主题下载失败，切换为默认主题"
  zsh_theme="ys"
fi

# plugin
highlighting_plugin="zsh-syntax-highlighting"

git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${omz_dir}/custom/plugins/zsh-syntax-highlighting"

if [[ $? != 0 ]]; then
  echo "命令行语法高亮插件，下载失败"
fi

# config profile
{
  echo "export ZSH=${omz_dir}"
  echo "ZSH_THEME=\""${zsh_theme}"\""
  echo "plugins=(git ${highlighting_plugin} vi-mode)"
  echo 'source $ZSH/oh-my-zsh.sh'
  echo -e '\n'
  echo '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh'
  echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh'
} > "config/zsh/omz.zsh"

cp "config/zsh/zshrc" "${HOME}/.config/zsh/zshrc"

if [[ -s "${HOME}/.zshrc" ]]; then
  mv "${HOME}/.zshrc" "${HOME}/.zshrc$(date +'%Y%m%d%M%H%S')"
fi

ln -s "${HOME}/.config/zsh/zshrc" "${HOME}/.zshrc"
sudo usermod -s "$(which zsh)" "${USER}"
