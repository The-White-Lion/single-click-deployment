#!/bin/bash

os_version=""
os_distro=""
os_architecture=""

function get_os_distro() {
    if [[ -f /etc/os-release ]]; then
        source /etc/os-release
        os_distro=$ID
    fi
}

function get_architecture() {
    case $(uname -m) in
        x86_64)
            os_architecture="amd64"
            ;;
    esac
    platform="linux-$os_architecture"
}

function get_os_info() {
    get_architecture
    get_os_release
}

function install_utils() {
    case "${os_distro}" in
        arch)
            sudo pacman -S $(< ../software.txt) --noconfirm
            ;;
        raspbian | debian | ubuntu)
            sudo apt install $(< ../software.txt) -y
            ;;
    esac
}

get_os_info
install_utils
source ../utils/installation_function.sh
