#!/bin/bash

echo 'installation des ssh'
sudo apt update && sudo apt install -y openssh-server

echo 'activation et demarrage de ssh'
sudo systemctl enable ssh
sudo systemctl start ssh

echo "configuration ssh : activation de l'authentification par password"
echo " nano  /etc/ssh/sshd_config puis enlever dieze sur PasswordAuthetification et permitRootLogin en mettant yes"

echo "demarrage de ssh"
sudo systemctl restart ssh

echo "config parefeu"
sudo ufw allow 22/tcp
sudo ufw enable -y
sudo ufw reload

echo "recup IP"
IP=$(hostname -I | awk '{print $1}')
PORT=$(sudo grep "^Port" /etc/ssh/sshd_config | awk '{print $2}')

echo "ssh actif sur :" echo " - IP : $IP" echo " - PORT : ${PORT:-22}"
