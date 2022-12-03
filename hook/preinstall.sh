#!/bin/bash

function load_utils() {
    source "${PWD}/utils/color.sh"
    source "${PWD}/utils/constant.sh"
    source "${PWD}/utils/directory.sh"
    source "${PWD}/utils/installation_function.sh"
    source "${PWD}/utils/os_info.sh"
}

function install_dependencies() {
    case "${os_distro}" in
        arch)
            sudo pacman -Syy
            sudo pacman -S $(< "${PWD}/dependency/arch") --noconfirm
            ;;
        raspbian | debian | ubuntu)
            sudo apt update
            sudo apt install $(< "${PWD}/dependency/ubuntu") -y
            ;;
        fedora)
            sudo dnf check-update -y
            sudo dnf install $(< "${PWD}/dependency/fedora") -y
            ;;
    esac
}

function set_proxy() {
    os_type="$(uname -r | awk -F "-" '{print $NF}')"
    if [[ "${os_type:0:3}" == "WSL" ]]; then
        proxy_ip="$(ip r | awk -F " " 'NR == 1 {print $3}')"
        export http_proxy="http://${proxy_ip}:7890"
        export https_proxy="http://${proxy_ip}:7890"
    fi
}

load_utils
set_proxy
get_os_info
install_dependencies

# Download Custom Config
if [[ ! -d "${GITHUB_DIR}/config" ]]; then
    git clone https://github.com/The-White-Lion/config.git "${GITHUB_DIR}/config" > /dev/null

    if [[ $? != 0 ]]; then
        red "配置仓库下载失败，请检查网络设置，程序退出"
        exit 0
    fi
else
    blue "配置仓库已经存在尝试更新"
    cd "${GITHUB_DIR}/config"

    git pull -r
    if [[ $? != 0 ]]; then
        red "配置仓库更新失败，请检查，程序退出"
        exit 0
    fi

    cd -
fi
