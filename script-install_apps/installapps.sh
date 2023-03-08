#!/bin/bash

# Verifica se o script está sendo executado como superusuário
if [ "$(id -u)" != "0" ]; then
   echo "Este script deve ser executado como superusuário (root ou sudo)." 1>&2
   exit 1
fi

# Atualiza a lista de pacotes
apt update

# Instala o Java 11
apt install -y openjdk-11-jdk

# Adiciona a chave GPG do Jenkins e adiciona o repositório ao sources.list.d
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null && \
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Atualiza a lista de pacotes novamente e instala o Jenkins
apt update
apt install -y jenkins 

# Instala o Docker e adiciona o usuário jenkins ao grupo docker
curl -fsSL https://get.docker.com | bash
usermod -aG docker jenkins

# Reinicia o serviço do Jenkins
systemctl restart jenkins

# Instala as dependências para o Kubernetes e adiciona o repositório ao sources.list.d
apt install -y ca-certificates curl apt-transport-https
curl -fsSLo /etc/apt/trusted.gpg.d/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/trusted.gpg.d/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list > /dev/null

# Atualiza a lista de pacotes novamente e instala o kubectl
apt update
apt install -y kubectl
