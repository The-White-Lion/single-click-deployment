#!/bin/bash

set -u

source "utils/os_info.sh"

case "${os_distro}" in
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

PYENV_ROOT="${HOME}/.github/pyenv"

if [[ -d "${PYENV_ROOT}" ]]; then
  rm -rf "${PYENV_ROOT}"
fi

git clone https://github.com/pyenv/pyenv.git "${PYENV_ROOT}" > /dev/null 2>&1

if [[ $? != 0 ]]; then
  echo "pyenv 下载失败"
  exit
fi

# compile a dynamic Bash extension to speed up Pyenv
cd "${PYENV_ROOT}" && src/configure && make -C src
cd -

{
  echo 'export PYENV_ROOT="$HOME/.github/pyenv"'
  echo 'export PATH="${PYENV_ROOT}/bin:$PATH"'
  echo 'eval "$(pyenv init -)"'
} > "config/zsh/env.zsh"
