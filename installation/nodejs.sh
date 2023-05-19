#!/bin/bash

set -u

NODE_ROOT="${HOME}/.development/node"
version="20.2.0"

if [[ -d "${NODE_ROOT}" ]]; then
  rm -rf "${NODE_ROOT}"
fi

mkdir -p "${NODE_ROOT}"

wget -O node.tar.gz "https://nodejs.org/dist/latest/node-v${version}-linux-x64.tar.gz"

if [[ $? != 0 ]]; then
  echo "nodejs 下载失败"
  exit
fi

tar --strip-components=1 -zxf node.tar.gz -C "${NODE_ROOT}"

rm -rf node.tar.gz

cp "config/npm/npmrc" "${HOME}/.nprc"

{
  echo '#Nodejs config'
  echo 'NODE_ROOT="${HOME}/.development/node"'
  echo 'export PATH="${NODE_ROOT}/bin:$PATH"'
} > "config/zsh/node_env.zsh"
