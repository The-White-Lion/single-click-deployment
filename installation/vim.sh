#!/bin/bash

set -u
source "utils/tools.sh"

case $(get_os_distro) in
    arch)
        sudo pacman -S vim --noconfirm
        ;;
    raspbian | debian | ubuntu)
        sudo apt install vim -y
        ;;
    fedora)
        sudo dnf install vim -y
        ;;
esac

cp "config/vim/vimrc" "${HOME}/.vimrc"

# Vim plugin manager
url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
save_as="${HOME}/.vim/autoload/plug.vim"
curl_down "${url}" "${save_as}"

# Install Plugin
vim +PlugInstall +qall
