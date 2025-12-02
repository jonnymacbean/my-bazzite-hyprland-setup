#!/bin/bash

set -ouex pipefail

# Install repos
dnf config-manager addrepo -y --from-repofile=https://repo.librewolf.net/librewolf.repo
dnf config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/beta/mullvad.repo
dnf -y copr enable solopasha/hyprland

# Enable writing to /opt
rm /opt
mkdir /opt

dnf -y remove plasma-* kde-*

# install packages
dnf install -y \
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
  sddm			\
	pipewire		\
	wofi			\
	brightnessctl \
  mullvad-vpn

# Cleanup
mv /opt /usr/share/factory
ln -s /var/opt /opt
rm -f mullvad-vpn.rpm
dnf -y copr disable solopasha/hyprland

#### Example for enabling a System Unit File

# systemctl enable podman.socket
