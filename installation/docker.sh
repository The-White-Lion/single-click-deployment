#!/bin/bash

set -u

source "utils/tools.sh"
docker_bin="$(command -v docker)"

if [[ -n "${docker_bin}" ]]; then
    echo "docker is installed on this system"
    "${docker_bin}" --version
    exit
fi


function debian() {
    local distro="${1}"
    # configure Docker Repository
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL "https://download.docker.com/linux/${distro}/gpg" | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/${distro} "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update -y > /dev/null 2>&1
    sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
}


function fedora() {
    sudo dnf install dnf-plugins-core -y > /dev/null 2>&1
    sudo dnf config-manager \
        --add-repo \
        https://download.docker.com/linux/fedora/docker-ce.repo \
        > /dev/null 2>&1

    sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
}


function arch() {
  sudo pacman -S docker docker-compose --noconfirm
}


echo "install docker ..."
case $(get_os_distro) in
    debian | ubuntu)
        debian $(get_os_distro)
        ;;
    ubuntu)
        ubuntu
        ;;
    fedora)
        fedora
        ;;
    arch)
        arch
        ;;
esac

# Settings
echo "config docker ..."
sudo usermod -aG docker "${USER}"

# Start with OS
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
