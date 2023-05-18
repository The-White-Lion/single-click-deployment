#!/bin/bash

set -u

source "utils/os_info.sh"

latest_version="$(curl -s https://go.dev/VERSION?m=text)"
if [[ -z "${latest_version}" ]]; then
  latest_version="go1.20.4"
fi

GOROOT="${HOME}/.development/go"
GOPATH="${HOME}/code/go"

if [[ -d "${GOROOT}" ]]; then
  rm -rf "${GOROOT}"
fi

[[ -d "${GOROOT}" ]] || mkdir -p "${GOROOT}"
[[ -d "${GOPATH}" ]] || mkdir -p "${GOPATH}"

package_name="${latest_version}.${platform}.tar.gz"
# https://go.dev/dl/go1.19.3.linux-armv6l.tar.gz
package_url="https://go.dev/dl/${package_name}"

wget --no-check-certificate --continue "${package_url}" -O "go.tar.gz" > /dev/null 2>&1

if [[ $? != 0 ]]; then
  echo "下载失败，检查是否设置代理"
  echo "下载链接：${package_url}"
  echo "退出开发环境安装"
  exit
fi

tar -C "${GOROOT}" --strip-components=1 -xzf "go.tar.gz"

rm -rf "go.tar.gz"

{
  echo "# Golang config"
  echo "export GOROOT=${GOROOT}"
  echo 'export PATH="${GOROOT}/bin:$PATH"'
  echo "export GOPATH=${GOPATH}"
  echo 'export PATH="${GOPATH}/bin:$PATH"'
} > "config/zsh/go_env.zsh"
