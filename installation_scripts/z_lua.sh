#!/bin/bash

git clone https://github.com/skywind3000/z.lua.git $GITHUB_DIR/z.lua > /dev/null


echo 'eval "$(lua' "$GITHUB_DIR/z.lua/z.lua" '--init zsh)"' > $ZSH_DIR/z_lua.zsh

# Todo 别名设置 细化配置
