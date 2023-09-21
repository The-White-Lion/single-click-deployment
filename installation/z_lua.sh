#!/bin/bash

set -u
source "utils/tools.sh"

z_path="${HOME}/.github/z.lua"

backup "${z_path}"
git_clone "skywind3000/z.lua.git" "${z_path}"

conf_dir="${HOME}/.config/zsh/"
z_lua="z_lua.zsh"

{
    echo 'eval "$(lua' "${z_path}/z.lua" '--init zsh enhanced once fzf echo)"' 
    echo "alias zc='z -c'  # restrict matches to subdirs of" '$PWD'
    echo "alias zi='z -i'  # cd with interactive selection"
    echo "alias zf='z -I'  # cd with interactive selection using fzf"
    echo "alias zb='z -b'  # cd to the parent directory starting with foo"
    echo "alias ze='z -e'  # echo the best match, don't cd"
} > "${z_lua}"

config "${conf_dir}" "${z_lua}"
