#!/bin/bash

os_version=""
os_distro=""
os_architecture=""
os_type=""

function get_os_distro() {
    if [[ -f /etc/os-release ]]; then
        source "/etc/os-release"
        os_distro="${ID}"
    fi
}

function get_os_architecture() {
    case "$(uname -m)" in
        x86_64)
            os_architecture="amd64"
            ;;
        aarch64)
            os_architecture="arm64"
            ;;
    esac
    platform="linux-${os_architecture}"
}

get_os_architecture
get_os_distro
