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

# KooL's Hyprland Dotfiles
git clone https://github.com/JaKooLit/Fedora-Hyprland.git
cd Fedora-Hyprland
echo <<EOF > presets.txt
gtk_themes="ON"
bluetooth="OFF"
thunar="ON"
quickshell="ON"
sddm="ON"
sddm_theme="ON"
xdph="OFF"
zsh="ON"
pokemon="ON"
rog="OFF"
dots="ON"
input_group="ON"
nvidia="OFF"
EOF

yes | ./install.sh presets.txt

# Cleanup
mv /opt /usr/share/factory
ln -s /var/opt /opt
rm -f mullvad-vpn.rpm
dnf -y copr disable solopasha/hyprland

#### Example for enabling a System Unit File

# systemctl enable podman.socket
