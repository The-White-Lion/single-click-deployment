#!/bin/bash

set -u

source "utils/os_info.sh"
docker_bin="$(command -v docker)"

if [[ -n "${docker_bin}" ]]; then
    echo "本系统已安装 docker"
    "${docker_bin}" version
    exit
fi

# different distro has different installation method
function ubuntu() {
    # configure Docker Repository
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update
    sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose -y
}

function fedora() {
    sudo dnf install dnf-plugins-core -y
    sudo dnf config-manager \
        --add-repo \
        https://download.docker.com/linux/fedora/docker-ce.repo

    sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
}

function arch() {
  sudo pacman -S docker docker-compose --noconfirm
}

case "${os_distro}" in
    raspbian | debian | ubuntu)
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
sudo usermod -aG docker "${USER}"

# Start with OS
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
