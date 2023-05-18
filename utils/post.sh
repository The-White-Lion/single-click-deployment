#!/bin/bash

env_file="config/zsh/env.zsh"
echo -n > "${env_file}"

for item in config/zsh/*_env.zsh
do
  echo ${item}
  cat "${item}" >> "${env_file}"
  echo >> "${env_file}"
done

rm -rf config/zsh/*_env.zsh
cp config/zsh/*.zsh ${HOME}/.config/zsh/
