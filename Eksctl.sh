#!/bin/bash

set -e

echo "🔄 Updating system..."
sudo apt update -y

echo "📦 Installing dependencies..."
sudo apt install -y curl unzip

# -------------------------------
# Install kubectl
# -------------------------------
echo "☸️ Installing kubectl..."
KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)

curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

echo "✅ kubectl installed:"
kubectl version --client

# -------------------------------
# Install eksctl
# -------------------------------
echo "⚙️ Installing eksctl..."

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" -o eksctl.tar.gz
tar -xzf eksctl.tar.gz
sudo mv eksctl /usr/local/bin/
rm eksctl.tar.gz

echo "✅ eksctl installed successfully:"
eksctl version

# -------------------------------
# Install AWS CLI v2
# -------------------------------
echo "☁️ Installing AWS CLI..."

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo "✅ AWS CLI installed:"
aws --version

# -------------------------------
# Final message
# -------------------------------
echo "🎉 Installation complete!"
echo "👉 Next step: run 'aws configure' to set credentials"
