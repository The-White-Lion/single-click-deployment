#!/bin/bash

set -u

source "utils/tools.sh"

latest=$(curl -s https://go.dev/VERSION?m=text | awk 'NR==1 { print $1 }')
if [[ -z "${latest}" ]]; then
  latest="go1.21.1"
fi

GOROOT="${HOME}/.development/go"
GOPATH="${HOME}/code/go"

backup "${GOROOT}"

[[ -d "${GOROOT}" ]] || mkdir -p "${GOROOT}"
[[ -d "${GOPATH}" ]] || mkdir -p "${GOPATH}"

# https://go.dev/dl/go1.19.3.linux-arm64.tar.gz
url="https://go.dev/dl/${latest}.linux-"$(get_os_architecture)".tar.gz"
package="go.tar.gz"

wget_down "${url}" "${package}"
tar -C "${GOROOT}" --strip-components=1 -xzf "${package}"
rm -rf "${package}"

conf="${HOME}/.config/zsh"
go_env="go_env.zsh"

{
  echo "# Golang config"
  echo "export GOROOT=${GOROOT}"
  echo "export GOPATH=${GOPATH}"
  echo 'export PATH="${GOROOT}/bin:${GOPATH}/bin:$PATH"'
} > "${go_env}"

config "${conf}" "${go_env}"
