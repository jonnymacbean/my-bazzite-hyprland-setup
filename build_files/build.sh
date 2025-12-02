#!/bin/bash

set -ouex pipefail

# Install repos
dnf config-manager addrepo -y --from-repofile=https://repo.librewolf.net/librewolf.repo
dnf config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/beta/mullvad.repo
dnf -y copr enable solopasha/hyprland

# Enable writing to /opt
rm /opt
mkdir /opt


# install packages
dnf install -y --allowerasing \
  librewolf \
  keepassxc \
  nautilus \
  hyprland-qt-support \
  hyprland-qtutils \
  hyprland \
  hyprpaper \
  hypridle \
  hyprlock \
  hyprsunset \
  hyprpanel \
  waypaper \
  hyprpolkitagent \
  hyprsysteminfo \
  alacritty \
  mullvad-vpn

# Cleanup
mv /opt /usr/share/factory
ln -s /var/opt /opt
rm -f mullvad-vpn.rpm
flatpak uninstall -y --noninteractive org.mozilla.firefox
dnf -y copr disable solopasha/hyprland

#### Example for enabling a System Unit File

# systemctl enable podman.socket
