#!/bin/bash

# Verificar se o usuário é root ou possui privilégios de sudo
if [[ $EUID -ne 0 ]]; then
   echo "Este script deve ser executado como root ou com privilégios de sudo" 
   exit 1
fi

# Baixar e instalar o Docker
curl -fsSL https://get.docker.com | bash --yes

# Adicionar o usuário atual ao grupo docker para evitar o uso constante de sudo
usermod -aG docker jenkins

# Reiniciar o serviço jenkins
systemctl restart jenkins
