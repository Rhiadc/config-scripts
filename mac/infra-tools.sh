#!/bin/bash

# Function to log messages
log() {
  echo "[SCRIPT] $1"
}

# Install Homebrew
if ! command -v brew &> /dev/null; then
  log "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Install dependencies
log "Installing dependencies..."
brew install git curl awscli go

# Install Vagrant
log "Installing Vagrant..."
brew install --cask vagrant

# Install Terraform
log "Installing Terraform..."
brew install terraform

# Install Ansible
log "Installing Ansible..."
brew install ansible

# Install Helm
log "Installing Helm..."
brew install helm

# Verify installation
log "Verifying installation..."
for package in "vagrant" "terraform" "ansible" "helm"; do
    if ! command -v "$package" &> /dev/null; then
        log "$package installation failed"
    else
        log "$package installed successfully"
    fi
done
