#!/bin/bash

# Function to log messages
log() {
  echo "[SCRIPT] $1"
}

# Update the package list and install necessary dependencies
log "Updating package list and installing dependencies..."
sudo apt update
sudo apt install -y curl git docker.io qbittorrent wireshark brave-browser awscli

# Install Go
log "Installing Go..."
sudo add-apt-repository -y ppa:longsleep/golang-backports
sudo apt update
sudo apt install -y golang-go

# Configure Docker to run without sudo
log "Configuring Docker..."
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Install and configure Minikube
if ! command -v minikube &> /dev/null; then
    log "Minikube not found. Skipping configuration..."
else
    log "Configuring Minikube..."
    minikube config set vm-driver virtualbox
    minikube config set memory 4096
    minikube config set cpus 4
    minikube config set kubernetes-version latest
    minikube start
    minikube addons enable ingress
    minikube addons enable dashboard
    minikube status
fi

# Install and configure Visual Studio Code
if ! command -v code &> /dev/null; then
    log "Visual Studio Code not found. Skipping configuration..."
else
    log "Configuring Visual Studio Code..."
    code --install-extension ms-azuretools.vscode-docker
    code --install-extension redhat.vscode-yaml
    code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
fi

# Install and configure Go
if ! command -v go &> /dev/null; then
    log "Go not found. Skipping configuration..."
else
    log "Configuring Go..."
    go get -u github.com/go-delve/delve/cmd/dlv
    go get -u github.com/golangci/golangci-lint/cmd/golangci-lint
    go get -u github.com/rakyll/gotest
    go get -u golang.org/x/tools/cmd/goimports
    go get -u golang.org/x/tools/gopls
    go get -u github.com/ramya-rao-a/go-outline
    go get -u github.com/uudashr/gopkgs/v2/cmd/gopkgs
fi

# Verify installation
log "Verifying installation..."
for package in "docker" "qbittorrent" "wireshark" "brave-browser" "aws" "go"; do
    if ! command -v "$package" &> /dev/null; then
        log "$package installation failed"
    else
        log "$package installed successfully"
    fi
done
