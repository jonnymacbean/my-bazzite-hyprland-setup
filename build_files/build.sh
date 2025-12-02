#!/bin/bash

set -ouex pipefail

# Install repos
dnf config-manager addrepo -y --from-repofile=https://repo.librewolf.net/librewolf.repo
dnf -y copr enable solopasha/hyprland


# install packages
dnf install -y \
  librewolf \
  keepassxc \
  nautilus \
  hyprland \
  hyprpaper \
  hypridle \
  hyprlock \
  hyprsunset \
  hyprpanel \
  waypaper \
  hyprpolkitagent \
  hyprsysteminfo \
  alacritty


# install Mullvad VPN
wget -O mullvad-vpn.rpm --trust-server-names https://mullvad.net/download/app/rpm/latest
dnf install ./mullvad-vpn.rpm

# Cleanup
rm -f mullvad-vpn.rpm
flatpak rm org.mozilla.firefox
dnf -y copr disable solopasha/hyprland

#### Example for enabling a System Unit File

# systemctl enable podman.socket
