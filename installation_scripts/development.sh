#!/bin/bash

go_bin="$(command -v go)"
if [[ -n "${go_bin}" ]]; then
  current_version="$(${go_bin} version | awk -F " " '{print $3}')"
  echo "当前系统已经安装 go 开发环境, 版本为：${current_version}"
  exit
fi

latest_version="$(curl -s https://go.dev/VERSION?m=text)"
if [[ -z "${latest_version}" ]]; then
  latest_version="go1.19.3"
fi

GOROOT="${HOEM}/.development/go"
GOPATH="${HOME}/code/go"
package_name="${latest_version}.${platform}.tar.gz"
# https://go.dev/dl/go1.19.3.linux-armv6l.tar.gz
package_url="https://go.dev/dl/${package_name}"

wget --no-check-certificate --continue "${package_url}" -O "${TMP_DIR}/go.tar.gz" > /dev/null 2>&1

if [[ $? != 0 ]]; then
  echo "下载失败，检查是否设置代理"
  echo "下载链接：${package_url}"
  echo "退出开发环境安装"
  exit
fi

tar -C "${GOROOT}" --strip-components=1 -xzf "${TMP_DIR}/go.tar.gz"
echo "配置 go 环境变量"

{
  echo "# Golang config"
  echo "export GOROOT=${GOROOT}"
  echo 'export PATH="$GOROOT/bin:$PATH"'
  echo "export GOPATH=${GOPATH}"
  echo 'export PATH="$GOPATH/bin:$PATH"'
} >> "${ZSH_DIR}/env.zsh"
