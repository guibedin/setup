# setup
Setup a new PC

## Initial Setup
```sh
# Install Git
sudo apt-get install -y git curl
git config --global user.email "guilherme0bedin@gmail.com"
git config --global user.name "Guilherme Bedin"

# Instal ansible
python3 -m venv .venv
source .venv/bin/activate
pip install ansible ansible-vault

# Setup ssh keys
curl "" -o ~/.ssh/id_rsa
curl "" -o ~/.ssh/id_rsa.pub
curl "" -o ~/.ssh/known_hosts

# Decrypt
ansible-vault decrypt ~/.ssh/id_rsa
ansible-vault decrypt ~/.ssh/id_rsa.pub

# Dont ask for password
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

mkdir personal
git clone git@github.com:guibedin/setup.git personal/setup
```


