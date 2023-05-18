#!/bin/bash

# pip install pynvim
# npm install -g neovim tree-sitter-cli
# ripgrep fdfind

mv "${HOME}/.config/nvim" "${HOME}/.config/nvim$(date +'%Y%m%d%H%M%S')"

cp -r "config/nvim" "${HOME}/.config/"
