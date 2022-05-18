#!/bin/bash

github_dir="$HOME/.github"
bin_dir="$HOME/.bin"
config_dir="$HOME/.config"
development_dir="$HOME/.development"
code_dir="$HOME/code"
tmp_dir="$HOME/.tmp"
zsh_dir="$config_dir/zsh"

[[ ! -d "$zsh_dir" ]] && mkdir "$zsh_dir"

[[ ! -d $github_dir ]] && mkdir "$github_dir"

[[ ! -d $bin_dir ]] && mkdir "$bin_dir"

[[ ! -d $config_dir ]] && mkdir "$config_dir"

[[ ! -d $development_dir ]] && mkdir "$development_dir"

[[ ! -d $code_dir ]] && mkdir "$code_dir"

[[ ! -d $tmp_dir ]] && mkdir "$tmp_dir"
