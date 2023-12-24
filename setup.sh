#!/bin/bash

# Install first packages
sudo apt-get install ca-certificates gnupg neovim \
  nfs-kernel-server qemu-kvm libvirt-daemon-system build-essential \
  libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev virt-manager \
  apt-transport-https tmux fzf htop rofi feh brightnessctl i3

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Create some dirs
mkdir ~/.local/bin
mkdir ~/.config/i3
mkdir ~/.config/kitty

# Get docker keyring
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Docker Repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
   tee /etc/apt/sources.list.d/docker.list > /dev/null

# Vagrant repository
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor |  sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Kubectl repository
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update

# Install Docker, Vagrant, Kubectl
sudo apt-get install docker-ce docker-ce-cli containerd.io \
  docker-buildx-plugin docker-compose-plugin vagrant kubectl

# Setup docker
groupadd docker
usermod -aG docker bedin
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo systemctl enable nfs-kernel-server.service

# Setup neovim
git clone git@github.com:guibedin/nvim.git ~/.config/nvim

# Create links
# Remove files if they exist
rm ~/.tmux.conf ~/.zshrc ~/.tmux-cht-command ~/.tmux-cht-languages \
  ~/.local/bin/tmux-sessionizer ~/.local/bin/easycd \
  ~/.config/i3/config ~/.config/i3/i3status.conf ~/.config/kitty/kitty.conf \
  /usr/bin/kitten /usr/bin/kitty ~/.local/share/fonts/JetBrainsMonoNerdFont-Bold.ttf

# Dot files
ln -s ~/personal/setup/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/personal/setup/dotfiles/.zshrc ~/.zshrc
ln -s ~/personal/setup/dotfiles/.tmux-cht-command ~/.tmux-cht-command
ln -s ~/personal/setup/dotfiles/.tmux-cht-languages ~/.tmux-cht-languages

# Scripts
ln -s ~/personal/setup/scripts/tmux-sessionizer.sh ~/.local/bin/tmux-sessionizer
ln -s ~/personal/setup/scripts/easycd.sh ~/.local/bin/easycd

# Confs
ln -s ~/personal/setup/config/i3/config ~/.config/i3/config
ln -s ~/personal/setup/config/i3/i3status.conf ~/.config/i3/i3status.conf
ln -s ~/personal/setup/config/kitty/kitty.conf ~/.config/kitty/kitty.conf

# Bins
sudo ln -s ~/.local/kitty.app/bin/kitten /usr/bin/kitten
sudo ln -s ~/.local/kitty.app/bin/kitty /usr/bin/kitty

# Fonts
ln -s ~/personal/setup/fonts/JetBrainsMonoNerdFont-Bold.ttf ~/.local/share/fonts/JetBrainsMonoNerdFont-Bold.ttf

# i3 brightness control
usermod -aG video bedin

# Vagrant plugins
vagrant plugin install vagrant-libvirt
