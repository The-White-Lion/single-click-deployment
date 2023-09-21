#!/bin/bash

set -u

source "utils/tools.sh"

case $(get_os_distro) in
    arch)
        sudo pacman -S python-pip --noconfirm
        ;;
    raspbian | debian | ubuntu)
        sudo apt install python3-pip -y
        ;;
    fedora)
        sudo dnf install python3-pip -y
        ;;
esac

pyenv_dir="${HOME}/.github/pyenv"

backup "${pyenv_dir}"

git_clone "pyenv/pyenv.git" "${pyenv_dir}"

# compile a dynamic Bash extension to speed up Pyenv
cd "${pyenv_dir}" && src/configure && make -C src
cd -

conf_dir="${HOME}/.config/zsh/"
pyenv_conf="pyenv.zsh"

{
  echo '#Pyenv config'
  echo 'export PYENV_ROOT="$HOME/.github/pyenv"'
  echo 'export PATH="${PYENV_ROOT}/bin:$PATH"'
  echo 'eval "$(pyenv init -)"'
} > "${pyenv_conf}"

config "${conf_dir}" "${pyenv_conf}"
