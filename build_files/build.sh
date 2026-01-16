#!/bin/bash

set -ouex pipefail

SKEL=/etc/skel

# Install repos
dnf config-manager addrepo -y --from-repofile=https://repo.librewolf.net/librewolf.repo
dnf config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/beta/mullvad.repo
dnf -y copr enable lbarrys/cliphist
dnf -y copr enable dejan/lazygit
dnf -y copr enable atim/bottom

# Enable writing to /opt
rm /opt
mkdir /opt

# ml4w dotfiles setup
git clone --depth 1 https://github.com/mylinuxforwork/dotfiles.git dotfiles
cd dotfiles
# janky workaround for this error: `unable to confirm: could not open a new TTY: open /dev/tty: no such device or address`
sed -i 's/gum confirm "DO YOU WANT TO START THE SETUP NOW?:/true/g' setup/_lib.sh
# janky workaround for running sudo as root
sed -i '2i sudo() { "$@" ; }' setup/setup-fedora.sh
HOME=$SKEL setup/setup-fedora.sh
cd dotfiles
cp -rf .config .Xresources .bashrc .gtkrc-2.0 .zshrc $SKEL
curl https://mylinuxforwork.github.io/ml4w-flatpak-repo/ml4w-apps-public-key.asc -o public.key
flatpak remote-add --if-not-exists ml4w-repo https://mylinuxforwork.github.io/ml4w-flatpak-repo/ml4w-apps.flatpakrepo --gpg-import=public.key
FLATPAKS="\
com.ml4w.hyprlandsettings \
com.ml4w.settings \
com.ml4w.sidebar \
com.ml4w.calendar \
com.ml4w.hyprlandsettings"
flatpak --system -y install --reinstall ml4w-repo $FLATPAKS
cd ../..

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
  ripgrep \
  lazygit \
  nodejs \
  nodejs-npm \
  bottom \
  golang \
  jetbrains-mono-fonts

# neovim setup
curl -o tree-sitter.gz 'https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz'
gzip -cd tree-sitter.gz > /usr/bin/tree-sitter
go install github.com/dundee/gdu/v5/cmd/gdu@latest
rm -rf $SKEL/.config/nvim
git clone --depth 1 https://github.com/AstroNvim/template $SKEL/.config/nvim
rm -rf ~/.config/nvim/.git

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
rm -rf tree-sitter.gz
dnf -y copr disable lbarrys/cliphist
dnf -y copr disable dejan/lazygit
dnf -y copr disable atim/bottom
