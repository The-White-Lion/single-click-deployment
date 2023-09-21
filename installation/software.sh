set -u

source "utils/tools.sh"

case $(get_os_distro) in
  arch)
    sudo pacman -Syy
    sudo pacman -S $(< "${PWD}/software/arch") --noconfirm
    ;;
  raspbian | debian | ubuntu)
    sudo apt update
    sudo apt install $(< "${PWD}/software/ubuntu") -y
    ;;
  fedora)
    sudo dnf check-update -y
    sudo dnf install $(< "${PWD}/software/fedora") -y
    ;;
esac
