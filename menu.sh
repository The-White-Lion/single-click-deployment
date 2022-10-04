#!/bin/bash

root_dir=$(pwd)

function menu() {
    green "==============================="
    green "  Linux 常用工具 一键安装脚本  "
    green "==============================="

    green " 1. 安装开发环境 "
    green " 2. 安装 z.lua "
    green " 3. 安装 fzf "
    green " 4. 安装 vim "
    green " 5. 退出 "
    echo

    read -p " 请输入数字：" input_number
    case "$input_number" in
        1)
            blue "安装开发环境"
            install_golang
            menu
            ;;
        2)
            blue "安装 z.lua"
            install_z_lua
            menu
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
            source $root_dir/hook/postinstall.sh
            clear
            exit 0
            ;;
        *)
            red "输入有误"
            menu
            ;;
    esac
}

source $root_dir/hook/preinstall.sh

menu
