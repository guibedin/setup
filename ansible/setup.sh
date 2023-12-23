#!/bin/bash

# Install first packages
sudo apt-get install wget zsh ca-certificates curl gnupg terminator neovim \
  nfs-kernel-server qemu-kvm libvirt-daemon-system build-essential \
  libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev virt-manager \
  apt-transport-https tmux fzf htop

# Create some dirs
mkdir ~/.local/bin
mkdir ~/.config/terminator
mkdir ~/.config/i3

# Change shell to zsh
chsh -s $(which zsh)

# Install oh my zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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
usermod -aG docker guilhermeb
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo systemctl enable nfs-kernel-server.service

# Setup neovim
git clone git@github.com:guibedin/nvim.git ~/.config/nvim

# Install Go
curl "https://go.dev/dl/go1.21.4.src.tar.gz"
sudo tar -C /usr/local -xzf go1.21.4.linux-amd64.tar.gz
rm go1.21.4.linux-amd64.tar.gz

# Create links
ln -s ~/personal/setup/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/personal/setup/dotfiles/.zshrc ~/.zshrc
ln -s ~/personal/setup/dotfiles/.tmux-cht-command ~/.tmux-cht-command
ln -s ~/personal/setup/dotfiles/.tmux-cht-languages ~/.tmux-cht-languages
ln -s ~/personal/setup/scripts/tmux-sessionizer.sh ~/.local/bin/tmux-sessionizer
ln -s ~/personal/setup/scripts/easycd.sh ~/.local/bin/easycd
ln -s ~/personal/setup/config/i3/config ~/.config/i3/config
ln -s ~/personal/setup/config/i3/i3status.conf ~/.config/i3/i3status.conf

# Vagrant plugins
vagrant plugin install vagrant-libvirt
