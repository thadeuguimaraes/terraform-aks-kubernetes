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