set -u

source "utils/tools.sh"

case $(get_os_distro) in
  arch)
    sudo pacman -Syy > /dev/null 2>&1
    sudo pacman -S $(< "${PWD}/software/arch") --noconfirm
    ;;
  raspbian | debian | ubuntu)
    sudo apt update > /dev/null 2>&1
    sudo apt install $(< "${PWD}/software/ubuntu") -y
    ;;
  fedora)
    sudo dnf check-update -y > /dev/null 2>&1
    sudo dnf install $(< "${PWD}/software/fedora") -y
    ;;
esac
