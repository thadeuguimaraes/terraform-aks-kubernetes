#!/bin/bash

# atualizar os pacotes do sistema
sudo apt update

# instalar o Java Runtime Environment (JRE) 11
sudo apt install -y openjdk-11-jdk

# obter a chave de segurança do Jenkins e adicioná-la ao keyring
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# adicionar o repositório do Jenkins ao sources.list.d
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# atualizar os pacotes novamente
sudo apt-get update

# instalar o Jenkins
sudo apt-get install -y jenkins 

# permissões para executar o arquivo chmod +x

cat /var/lib/jenkins/secrets/initialAdminPassword
# ===============================================================================================================

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

# ==================================================================================================================

# Atualiza os repositórios do apt-get
sudo apt-get update

# Instala os pacotes necessários para o Kubernetes
sudo apt-get install -y ca-certificates curl apt-transport-https

# Adiciona a chave de segurança do Kubernetes
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

# Adiciona o repositório do Kubernetes ao apt-get
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Atualiza novamente os repositórios do apt-get
sudo apt-get update

# Instala o kubectl
sudo apt-get install -y kubectl

