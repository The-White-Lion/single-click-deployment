#!/bin/bash

case "${os_distro}" in
    arch)
        sudo pacman -S vim --noconfirm
        ;;
    raspbian | debian | ubuntu)
        sudo apt install vim -y
        ;;
esac

git clone https://github.com/The-White-Lion/config.git "$tmp_dir/config" > /dev/null

cp "$tmp_dir/config/vim/vimrc" "$HOME/.vimrc"

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
