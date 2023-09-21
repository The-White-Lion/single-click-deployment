#!/bin/bash

# Print error message to STDERR and exit
function die() {
    echo >&2 "$*"
    exit 1
}

# Back up directory or file
function backup() {
    local path="${1}"
    if [[ -d "${path}" ]]; then
        mv "${path}" "${path}$(date +'%Y%m%d%H%M%S')"
    fi

    if [[ -f "${path}" ]]; then
        mv "${path}" "${path}$(date +'%Y%m%d%H%M%S')"
    fi
}

# Download github repository
function git_clone(){
    local repository_url="${1}"
    local target_dir="${2}"
    local name=$3
    echo "start download: ${name}"
    git clone --depth=1 "https://github.com/${repository_url}" "${target_dir}" 2>&1 >> /dev/null
    if [[ $? != 0 ]]; then
        die "failed to download [${name}], please check your system's network configuration and especiall the proxy settings"
    fi
}

# Moves the configuration file to the right place and clean up the tmp files
function config() {
    local conf_dir="${1}"
    local conf_file="${2}"
    [[ -d "${conf_dir}" ]] || mkdir -p "${conf_dir}"
    mv "${conf_file}" "${conf_dir}"
}

# Download file with curl
function curl_down() {
    url="${1}"
    save_as="${2}"

    curl -sfLo -o "${save_as}" --create-dirs "${url}" 2>&1 >> /dev/null

    if [[ $? != 0 ]]; then
        die "failed to download [${save_as}], [${url}]"
    fi
}

function get_os_distro() {
    if [[ -f /etc/os-release ]]; then
        source "/etc/os-release"
        echo -n "${ID}"
    fi
}

function get_os_architecture() {
    case "$(uname -m)" in
        x86_64)
            echo -n "amd64"
            ;;
        aarch64)
            echo -n "arm64"
            ;;
    esac
}
