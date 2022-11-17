#!/bin/bash

function load_utils() {
    source "$PWD/utils/color.sh";
    source "$PWD/utils/constant.sh";
    source "$PWD/utils/directory.sh";
    source "$PWD/utils/installation_function.sh";
    source "$PWD/utils/os_info.sh";
}

function install_dependencies() {
    case "${os_distro}" in
        arch)
            sudo pacman -Syy
            sudo pacman -S $(< "$PWD/dependencies.txt") --noconfirm
            ;;
        raspbian | debian | ubuntu)
            sudo apt update
            sudo apt install $(< "$PWD/dependencies.txt") -y
            ;;
    esac
}

function set_proxy() {
    os_type=$(uname -r | awk -F "-" '{print $NF}')
    if [[ ${os_type:0:3} == "WSL" ]]; then
        proxy_ip=$(ip r | awk -F " " 'NR == 1 {print $3}')
        export http_proxy=http://$proxy_ip:7890
        export https_proxy=http://$proxy_ip:7890
    fi
}

load_utils
set_proxy
get_os_info
install_dependencies

# Download Custom Config
git clone https://github.com/The-White-Lion/config.git "$TMP_DIR/config" > /dev/null
