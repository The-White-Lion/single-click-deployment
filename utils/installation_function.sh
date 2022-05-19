#!/bin/bash
function install_z_lua() {
    source "$root_dir"/installation_scripts/z_lua.sh
}

function install_vim() {
    source "$root_dir"/installation_scripts/vim.sh
}

function install_omz() {
    source "$root_dir"/installation_scripts/omz.sh
}

source "$root_dir"/installation_scripts/dev_environments.sh
