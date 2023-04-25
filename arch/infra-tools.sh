#!/bin/bash

# Function to log messages
log() {
  echo "[SCRIPT] $1"
}

# Update the package list and install necessary dependencies
log "Updating package list and installing dependencies..."
sudo pacman -Syu
sudo pacman -S --noconfirm git curl aws-cli go

# Install Vagrant
log "Installing Vagrant..."
sudo pacman -S --noconfirm vagrant

# Install Terraform
log "Installing Terraform..."
sudo pacman -S --noconfirm terraform

# Install Ansible
log "Installing Ansible..."
sudo pacman -S --noconfirm ansible

# Install Helm
log "Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Configure Docker to run without sudo
log "Configuring Docker..."
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Verify installation
log "Verifying installation..."
for package in "vagrant" "terraform" "ansible" "helm"; do
    if ! command -v "$package" &> /dev/null; then
        log "$package installation failed"
    else
        log "$package installed successfully"
    fi
done
