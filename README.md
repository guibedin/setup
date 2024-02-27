# setup
Setup a new PC

## Initial Setup
```sh
sudo apt-get update

# Install Git
sudo apt-get install -y git curl wget zsh 
git config --global user.email "guilherme0bedin@gmail.com"
git config --global user.name "Guilherme Bedin"

# Change shell to zsh
chsh -s $(which zsh)

# Install oh my zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Instal ansible
python3 -m venv .venv
source .venv/bin/activate
pip install ansible ansible-vault

# Setup ssh keys
sh create_keys.sh

# Decrypt
ansible-vault decrypt ~/.ssh/id_rsa
ansible-vault decrypt ~/.ssh/id_rsa.pub

# Dont ask for password
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

mkdir personal
git clone git@github.com:guibedin/setup.git personal/setup
```
