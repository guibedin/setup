#!/bin/bash

## Install Git
sudo apt-get install -y git
git config --global user.email "guilherme0bedin@gmail.com"
git config --global user.name "Guilherme Bedin"

## Instal ansible
python3 -m venv .venv
source .venv/bin/activate
pip install ansible ansible-vault

## 

