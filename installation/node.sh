#!/bin/bash

set -u
source "utils/tools.sh"

NODE_ROOT="${HOME}/.development/node"

if [[ -d "${NODE_ROOT}" ]]; then
  rm -rf "${NODE_ROOT}"
fi

mkdir -p "${NODE_ROOT}"

arch=$(get_os_architecture)

if [[ "${arch}" == "amd64" ]]; then
    arch="x64"
fi

url="https://nodejs.org/dist/v18.18.0/node-v18.18.0-linux-${arch}.tar.gz"
package="node.tar.gz"

wget_down "${url}" "${package}"
tar -C "${NODE_ROOT}" --strip-components=1 -xzf "${package}"
rm -rf "${package}"

cp "config/npm/npmrc" "${HOME}/.npmrc"

conf="${HOME}/.config/zsh"
node_env="node_env.zsh"

{
  echo '# Nodejs config'
  echo 'NODE_ROOT="${HOME}/.development/node"'
  echo 'export PATH="${NODE_ROOT}/bin:$PATH"'
} > "${node_env}"

config "${conf}" "${node_env}"
