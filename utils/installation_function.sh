#!/bin/bash

function install_z_lua() {
    source "${PWD}/installation_scripts/z_lua.sh"
}

function install_vim() {
    source "${PWD}/installation_scripts/vim.sh"
}

function install_omz() {
    source "${PWD}/installation_scripts/omz.sh"
}

function install_ranger() {
    source "${PWD}/installation_scripts/ranger.sh"
}

function install_docker() {
    source "${PWD}/installation_scripts/docker.sh"
}

source "${PWD}/installation_scripts/dev_environments.sh"
