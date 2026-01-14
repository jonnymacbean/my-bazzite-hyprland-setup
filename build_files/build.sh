#!/bin/bash

set -ouex pipefail

# Install repos
dnf config-manager addrepo -y --from-repofile=https://repo.librewolf.net/librewolf.repo
dnf config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/beta/mullvad.repo
dnf -y copr enable lbarrys/cliphist

# Enable writing to /opt
rm /opt
mkdir /opt

# ml4w dotfiles setup
git clone --depth 1 https://github.com/mylinuxforwork/dotfiles.git dotfiles
cd dotfiles
alias gum=echo
HOME=/etc/skel setup/setup-fedora.sh
cp -rf dotfiles/* /etc/skel

# install packages
dnf install -y \
  sddm \
  librewolf \
  keepassxc \
  mullvad-vpn \
  hyprpolkitagent \
  hyprutils \
  ncdu \
  tealdeer \
  gamemode \
  ripgrep
  

# SDDM theme
git clone -b master --depth 1 https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
cp -r /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/
echo "[Theme]
Current=sddm-astronaut-theme" | tee /etc/sddm.conf
echo "[General]
InputMethod=qtvirtualkeyboard" | tee /etc/sddm.conf.d/virtualkbd.conf
sed -i 's|ConfigFile=Themes/astronaut.conf|ConfigFile=Themes/black_hole.conf|g' /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop

  
# Cleanup
rm -rf dotfiles
dnf -y copr disable lbarrys/cliphist
