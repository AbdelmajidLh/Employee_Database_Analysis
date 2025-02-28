#!/bin/bash

set -e  # Arrête le script en cas d'erreur

echo "🔄 Mise à jour du système..."
sudo apt update && sudo apt upgrade -y

# ==========================
# 1️⃣ INSTALLER DOCKER & DOCKER COMPOSE
# ==========================
echo "🐳 Installation de Docker..."
sudo apt install -y docker.io
sudo systemctl enable --now docker

echo "📦 Installation de Docker Compose..."
DOCKER_COMPOSE_VERSION="1.29.2"
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# ==========================
# 2️⃣ AJOUTER L’UTILISATEUR AU GROUPE DOCKER
# ==========================
echo "🔑 Ajout de l'utilisateur courant au groupe Docker..."
sudo groupadd docker || true
sudo usermod -aG docker $USER
sudo systemctl restart docker

# ==========================
# 3️⃣ CONFIGURATION SSH POUR JENKINS
# ==========================
echo "🔑 Configuration SSH pour Jenkins..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh

echo "✅ Installation terminée !"
echo "🖥️ Jenkins peut maintenant déployer des applications sur ce serveur."
