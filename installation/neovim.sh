#!/bin/bash

pip install pynvim
npm install -g neovim tree-sitter-cli
# ripgrep fdfind luajit
# 当前仅考虑 arch linux

sudo pacman -S ripgrep fdfind luajit --noconfirm

mv "${HOME}/.config/nvim" "${HOME}/.config/nvim$(date +'%Y%m%d%H%M%S')"

cp -r "config/nvim" "${HOME}/.config/"
