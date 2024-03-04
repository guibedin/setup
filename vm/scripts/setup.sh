#!/bin/bash

# Install Oh My ZSH
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Kind and Helm
go install sigs.k8s.io/kind@v0.22.0
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash