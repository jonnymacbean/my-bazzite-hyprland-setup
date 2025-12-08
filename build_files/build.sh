#!/bin/bash

set -ouex pipefail

# Install repos
dnf config-manager addrepo -y --from-repofile=https://repo.librewolf.net/librewolf.repo
dnf config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/beta/mullvad.repo
dnf config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/shells:zsh-users:zsh-completions/Fedora_Rawhide/shells:zsh-users:zsh-completions.repo
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
  mullvad-vpn \
  wget \
  unzip \
  gum \
  rsync \
  git \
  figlet \
  xdg-user-dirs \
  hyprland \
  hyprland-contrib \
  hyprpaper \
  hyprlock \
  hypridle \
  hyprpicker \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal-hyprland \
  libnotify \
  kitty \
  qt5-qtwayland \
  qt6-qtwayland \
  fastfetch \
  python-pip \
  python-gobject \
  python-screeninfo \
  tumbler \
  brightnessctl \
  nm-connection-editor \
  network-manager-applet \
  ImageMagick \
  jq \
  xclip \
  kitty \
  neovim \
  htop \
  blueman \
  grim \
  slurp \
  cliphist \
  nwg-look \
  qt6ct \
  waybar \
  rofi-wayland \
  zsh \
  zsh-completions \
  fzf \
  pavucontrol \
  papirus-icon-theme \
  plasma-breeze \
  breeze-gtk \
  flatpak \
  swaync \
  gvfs \
  wlogout \
  waypaper \
  fontawesome-fonts \
  fira-code-fonts \
  nwg-dock-hyprland \
  vlc
  #rust-eza \
  # polkit-gnome \
  # bibata-cursor-theme \
  # pacseek \
  # power-profiles-daemon \
  # python-pywalfox \

flatpak install flathub com.ml4w.dotfilesinstaller

# Cleanup
mv /opt /usr/share/factory
ln -s /var/opt /opt
dnf -y copr disable solopasha/hyprland

#### Example for enabling a System Unit File

# systemctl enable podman.socket
