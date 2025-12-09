#!/bin/bash

set -ouex pipefail

# Install repos
dnf config-manager addrepo -y --from-repofile=https://repo.librewolf.net/librewolf.repo
dnf config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/beta/mullvad.repo
dnf config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/shells:zsh-users:zsh-completions/Fedora_Rawhide/shells:zsh-users:zsh-completions.repo
dnf -y copr enable solopasha/hyprland
dnf -y copr enable peterwu/rendezvous
dnf -y copr enable lbarrys/cliphist
dnf -y copr enable tofik/nwg-shell
dnf -y copr enable erikreider/SwayNotificationCenter

# Enable writing to /opt
rm /opt
mkdir /opt

dnf -y remove plasma-* kde-*

# install packages
dnf install -y \
  sddm \
  librewolf \
  keepassxc \
  mullvad-vpn \
  hyprland \
  libnotify \
  qt5-qtwayland \
  qt6-qtwayland \
  uwsm \
  python-pip \
  python3-gobject \
  nm-connection-editor \
  network-manager-applet \
  fuse \
  ImageMagick \
  NetworkManager-tui \
  waypaper \
  SwayNotificationCenter \
  fontawesome-fonts \
  wget \
  curl \
  git \
  rsync \
  unzip \
  jq \
  flatpak \
  vim \
  inotify-tools \
  hyprpaper \
  hyprlock \
  hypridle \
  hyprpicker \
  xdg-desktop-portal-hyprland \
  kitty \
  wlogout \
  vlc \
  nwg-dock-hyprland \
  waybar \
  rofi-wayland \
  nwg-look \
  pavucontrol \
  neovim \
  blueman \
  qt6ct \
  nautilus \
  xdg-user-dirs \
  xdg-desktop-portal-gtk \
  figlet \
  fastfetch \
  htop \
  xclip \
  zsh \
  fzf \
  brightnessctl \
  tumbler \
  slurp \
  cliphist \
  gvfs \
  grim \
  breeze-gtk \
  plasma-breeze

git clone --depth 1 https://github.com/mylinuxforwork/dotfiles.git dotfiles
cd dotfiles/setup
cp packages/eza /usr/bin
cp scripts/grimblast /usr/bin
cp -rf fonts/* /usr/share/fonts
cd ../..
  

  
# Cleanup
mv /opt /usr/share/factory
rm -rf dotfiles
ln -s /var/opt /opt
dnf -y copr disable solopasha/hyprland
dnf -y copr disable peterwu/rendezvous
dnf -y copr disable lbarrys/cliphist
dnf -y copr disable tofik/nwg-shell
dnf -y copr disable erikreider/SwayNotificationCenter
