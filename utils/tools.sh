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

    echo "start download: ${target_dir}"

    git clone --depth=1 "https://github.com/${repository_url}" "${target_dir}" > /dev/null 2>&1

    if [[ $? != 0 ]]; then
        die "failed to download [${repository_url}]"
    fi
    echo "download complete"
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

    echo "start download ${save_as}"
    curl -sfLo -o "${save_as}" --create-dirs "${url}" > /dev/null 2>&1

    if [[ $? != 0 ]]; then
        die "failed to download [${url}]"
    fi
    echo "download complete"
}


function wget_down() {
    url="${1}"
    save_as="${2}"

    echo "start downlaod ${save_as}"
    wget --no-check-certificate --continue "${url}" -O "${save_as}" > /dev/null 2>&1

    if [[ $? != 0 ]]; then
        die "failed to download [${url}]"
    fi
    echo "download complete"
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
