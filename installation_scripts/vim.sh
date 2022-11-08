#!/bin/bash

case "${os_distro}" in
    arch)
        sudo pacman -S vim --noconfirm
        ;;
    raspbian | debian | ubuntu)
        sudo apt install vim -y
        ;;
esac

cp "$TMP_DIR/config/vim/vimrc" "$HOME/.vimrc"

# Vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

yellow "vim 安装完成，请在 vim 中使用 :PlugInstall 更新插件"
