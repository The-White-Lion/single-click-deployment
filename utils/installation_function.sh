#!/bin/bash
function install_z_lua() {
    source "$root_dir"/installation_scripts/z_lua.sh
}

function install_vim() {
    source "$root_dir"/installation_scripts/vim.sh
}

source "$root_dir"/installation_scripts/dev_environments.sh
