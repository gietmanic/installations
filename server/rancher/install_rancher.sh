#!/bin/bash

# Rancher Installation Script for Cloud Server
# Author: Daniel Gietmann
# Date: 11.03.2025

# Ensure script runs as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Ask user if they want to use a domain
read -p "Do you want to use a domain for Rancher? (yes/no): " use_domain

if [[ "$use_domain" == "yes" ]]; then
    read -p "Enter your domain: " DOMAIN
fi

# Variables
RANCHER_IMAGE="rancher/rancher:latest"

# Update system and install dependencies
echo "Updating system..."
apt update && apt upgrade -y
apt install -y curl jq git ufw

# Install Docker
echo "Installing Docker..."
curl -fsSL https://get.docker.com | bash
usermod -aG docker $USER
systemctl enable --now docker

# Verify Docker installation
docker --version

# Open required ports
echo "Configuring firewall..."
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable

# Run Rancher container
echo "Starting Rancher..."
if [[ "$use_domain" == "yes" ]]; then
    docker run -d --restart=unless-stopped \
      -p 80:80 -p 443:443 \
      --name rancher \
      --privileged \
      $RANCHER_IMAGE \
      --acme-domain $DOMAIN
    echo "Rancher is now running at: https://$DOMAIN"
else
    docker run -d --restart=unless-stopped \
      -p 80:80 -p 443:443 \
      --name rancher \
      --privileged \
      $RANCHER_IMAGE
    echo "Rancher is now running at: https://your-server-ip"
fi
