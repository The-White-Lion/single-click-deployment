set -u

source "utils/os_info.sh"

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
