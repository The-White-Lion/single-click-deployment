#!/bin/bash

function show_menu() {
    green "==============================="
    green "  Linux 常用工具 一键安装脚本  "
    green "==============================="

    green " 1. 安装开发环境 "
    green " 2. 安装 z.lua "
    green " 3. 安装 oh-my-zsh "
    green " 4. 安装 vim "
    green " 5. 安装 ranger"
    green " 6. 退出 "
    echo
}

function list_soft() {
    read -p " 请输入数字：" input_number
    case "$input_number" in
        1)
            blue "安装开发环境"
            install_golang
            install_lua
            ;;
        2)
            blue "安装 z.lua"
            install_z_lua
            ;;
        3)
            blue "安装 oh-my-zsh"
            install_omz
            ;;
        4)
            blue "安装 vim"
            install_vim
            ;;
        5)
            blue "安装 ranger"
            install_ranger
            ;;
        6)
            source "$PWD"/hook/postinstall.sh
            exit 0
            ;;
        *)
            red "输入有误"
            ;;
    esac
}

function main() {
    while true
    do
        show_menu
        list_soft
    done
}

source "$PWD"/hook/preinstall.sh

main
