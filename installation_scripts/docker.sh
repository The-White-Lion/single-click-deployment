#!/bin/bash

docker_bin="$(command -v docker)"

if [[ -n "${docker_bin}" ]]; then
    blue "本系统已安装 docker"
    "${docker_bin}" version
    return 0
fi

# Different distro has different installation method
function ubuntu() {
    # Configure Docker Repository
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update
    sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
}

function fedora() {
    sudo dnf install dnf-plugins-core -y
    sudo dnf config-manager \
        --add-repo \
        https://download.docker.com/linux/fedora/docker-ce.repo

    sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
}

case "${os_distro}" in
    raspbian | debian | ubuntu)
        ubuntu
        ;;
    fedora)
        fedora
        ;;
esac

# Settings
sudo usermod -aG docker "${USER}"

# Start with OS
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

yellow "docker 安装完成"
