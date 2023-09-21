#!/bin/bash

# This function is used to back up directory or file
# it takes one argument
# arg1: file or directory name
function backup() {
    local path=$1
    if [[ -d "${path}" ]]; then
        mv "${path}" "${path}$(date +'%Y%m%d%H%M%S')"
    fi

    if [[ -f "${path}" ]]; then
        mv "${path}" "${path}$(date +'%Y%m%d%H%M%S')"
    fi
}

# This function is used to download the github repository
# it takes three arguments
# arg1: the repository url where need to download
# arg2: the target directory where arg1 to be saved
# arg3: the name of the arg1 to download
function git_clone(){
    local repository_url=$1
    local target_dir=$2
    local name=$3
    echo "start download: ${name}"
    git clone --depth=1 "https://github.com/${repository_url}" "${target_dir}"
    if [[ $? != 0 ]]; then
        echo "failed to download [${name}], please check your system's network configuration and especiall the proxy settings"
    fi
}

