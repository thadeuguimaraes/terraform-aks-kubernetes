#!/bin/bash

# Verifica se está sendo executado como superusuário
if [ "$(id -u)" != "0" ]; then
   echo "Este script deve ser executado como superusuário (root ou sudo)." 1>&2
   exit 1
fi

# atualizar os pacotes do sistema
apt update

# instalar o Java Runtime Environment (JRE) 11
apt install -y openjdk-11-jdk

# obter a chave de segurança do Jenkins e adicioná-la ao keyring
sudo curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# adicionar o repositório do Jenkins ao sources.list.d
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# atualizar os pacotes novamente
apt update

# instalar o Jenkins
apt install -y jenkins 

# ===============================================================================================================
# Baixar e instalar o Docker
sudo curl -fsSL https://get.docker.com | bash

# Adicionar o usuário atual ao grupo docker para evitar o uso constante de sudo
usermod -aG docker jenkins

# Reiniciar o serviço do Jenkins
systemctl restart jenkins

# Instala os pacotes necessários para o Kubernetes
apt install -y ca-certificates curl apt-transport-https

# Adiciona a chave de segurança do Kubernetes
curl -fsSLo /etc/apt/trusted.gpg.d/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

# Adiciona o repositório do Kubernetes ao apt-get
echo "deb [signed-by=/etc/apt/trusted.gpg.d/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list > /dev/null

# Atualiza novamente os repositórios do apt-get
apt update

# Instala o kubectl
apt install -y kubectl
