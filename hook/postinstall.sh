#!/bin/bash

install_omz

[[ ! -f $aliases_conf ]] && touch $aliases_conf
[[ ! -f $env_conf ]] && touch $env_conf

{
    for f in "$zsh_dir"/*.zsh;
    do
        echo "source $f"
    done
} >> "$zshrc_conf"
