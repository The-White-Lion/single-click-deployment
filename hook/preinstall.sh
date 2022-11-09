#!/bin/bash

os_version=""
os_distro=""
os_architecture=""
os_type=""

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
        armv7l)
            os_architecture="armv7l"
            ;;
        aarch64)
            os_architecture="arm64"
            ;;
    esac
    platform="linux-$os_architecture"
}

function get_os_info() {
    get_architecture
    get_os_distro
}

function install_utils() {
    case "${os_distro}" in
        arch)
            sudo pacman -S $(< "$PWD/software.txt") --noconfirm
            ;;
        raspbian | debian | ubuntu)
            sudo apt install $(< "$PWD/software.txt") -y
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

set_proxy
get_os_info
install_utils

for f in "$PWD"/utils/*;
do
    source $f
done

# Download my config
git clone git@github.com:The-White-Lion/config.git "$TMP_DIR/config" > /dev/null
