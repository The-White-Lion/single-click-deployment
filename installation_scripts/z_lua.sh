#!/bin/bash

git clone https://github.com/skywind3000/z.lua.git $github_dir/z.lua > /dev/null

echo 'eval "$(lua $github_dir/z.lua/z.lua  --init zsh)"' >> .zshrc
