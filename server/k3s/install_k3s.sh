#!/bin/bash

# Rancher Installation Script for Cloud Server
# Author: Daniel Gietmann
# Date: 11.03.2025

# Ensure script runs as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Install dependencies
echo "Updating system and installing dependencies..."
apt update && apt upgrade -y
apt install -y curl jq ufw

# Install K3s (Lightweight Kubernetes)
echo "Installing K3s..."
curl -sfL https://get.k3s.io | sh -

# Check if K3s is running
echo "Checking K3s status..."
systemctl enable k3s
systemctl start k3s

# Configure environment variables
echo "Configuring environment variables..."
echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' >> ~/.bashrc
source ~/.bashrc

# Open firewall ports
echo "Configuring firewall..."
ufw allow 6443/tcp
ufw allow 10250/tcp
ufw --force enable

# Output cluster connection details
echo "Cluster is ready! 🏗️"
echo "Use the following command to check nodes:"
echo "kubectl get nodes"

# Print join command for worker nodes
echo "If you want to add worker nodes, use this command on them:"
cat /var/lib/rancher/k3s/server/node-token
