#!/bin/bash

font_latest_version="$(curl -fsSL https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep "tag_name" | head -n 1 | awk -F ": " '{print $2}'| sed 's/,//g' | sed 's/\"//g')"

cascadiacode="https://github.com/ryanoasis/nerd-fonts/releases/download/${font_latest_version}/CascadiaCode.zip"
jetbrainsmono="https://github.com/ryanoasis/nerd-fonts/releases/download/${font_latest_version}/JetBrainsMono.zip"

cascadia_font="${TMP_DIR}/CascadiaCode.zip"
jetbrains_font="${TMP_DIR}/JetbrainsMono.zip"

blue "download ${cascadiacode}"
curl -sL "${cascadiacode}" -o "${cascadia_font}"
blue "download ${jetbrainsmono}"
curl -sL "${jetbrainsmono}" -o "${jetbrains_font}"
blue "fonts download complete"

unzip -o "${jetbrains_font}" -d "${FONT_DIR}/JetbrainsMono"
unzip -o "${cascadia_font}" -d "${FONT_DIR}/CascadiaCode"

# *Windows* 放到引号内会出错，无法正常的删除的问题，此处记录一下，留待解决
rm -rf "${HOME}/.local/share/fonts/JetbrainsMono/"*Windows*
rm -rf "${HOME}/.local/share/fonts/CascadiaCode/"*Windows*

fc-cache -f
