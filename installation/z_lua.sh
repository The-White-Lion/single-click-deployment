#!/bin/bash

z_path="${HOME}/tmp/z.lua"

if [[ -d "${z_path}" ]]; then
  rm -rf "${z_path}"
fi

git clone https://github.com/skywind3000/z.lua.git "${z_path}" > /dev/null 2>&1

if [[ $? != 0 ]]; then
  echo "z.lua 下载失败，检查网络连接"
  exit
fi

{
  echo 'eval "$(lua' "${z_path}/z.lua" '--init zsh enhanced once fzf echo)"' 
  echo "alias zc='z -c'   # 严格匹配当前路径的子路径"
  echo "alias zz='z -i'   # 使用交互式选择模式"
  echo "alias zf='z -I'   # 使用 fzf 对多个结果进行选择"
  echo "alias zb='z -b'   # 快速回到父目录"
} > "config/zsh/z_lua.zsh"
