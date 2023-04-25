#!/bin/bash

# Manjaro installation script for common development tools

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}This script must be run as root.${NC}" >&2
    exit 1
fi

# Update package manager
echo -e "${GREEN}Updating package manager...${NC}"
if ! pacman -Syu --noconfirm; then
    echo -e "${RED}Failed to update package manager.${NC}" >&2
    exit 1
fi

# Install packages
echo -e "${GREEN}Installing packages...${NC}"
if ! pacman -S --noconfirm \
    docker \
    qbittorrent \
    wireshark \
    brave \
    go \
    vagrant \
    terraform \
    ansible \
    helm \
    kubectl; then
    echo -e "${RED}Failed to install packages.${NC}" >&2
    exit 1
fi

# Install kubectx and kubens
echo -e "${GREEN}Installing kubectx and kubens...${NC}"
if ! git clone https://github.com/ahmetb/kubectx.git ~/.kubectx && \
    ln -sf ~/.kubectx/completion/kubectx /etc/bash_completion.d/kubectx && \
    ln -sf ~/.kubectx/completion/kubens /etc/bash_completion.d/kubens; then
    echo -e "${RED}Failed to install kubectx and kubens.${NC}" >&2
    exit 1
fi

# Verify installation
echo -e "${GREEN}Verifying installation...${NC}"
for package in "docker" "qbittorrent" "wireshark" "brave" "go" "vagrant" "terraform" "ansible" "helm" "kubectl" "kubectx" "kubens"; do
    if ! command -v "$package" &> /dev/null; then
        echo -e "${RED}$package installation failed.${NC}"
    else
        echo -e "${GREEN}$package installed successfully.${NC}"
    fi
done

echo -e "${GREEN}All packages installed successfully.${NC}"
