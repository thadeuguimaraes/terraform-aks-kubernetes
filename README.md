# Introdução ao src_terraform para provisionar o Cluster Kubernets na Azure e a criação de uma VM Ubuntu-Linux

Este é um código Terraform que provisiona um cluster Kubernetes em uma conta do Azure, que pode ser usado para implantar aplicativos em contêiner.

1. Configura a versão do Terraform e os provedores necessários.
2. Configura o backend do Azure para armazenar o estado remoto do Terraform.
3. Cria um recurso de cluster Kubernetes no Azure com uma pool de nós padrão.
4. Cria uma interface de rede para o cluster.
5. Configura o acesso SSH para a VM.
6. Cria um disco do sistema operacional para a VM.
7. Configura os recursos de rede, como um endereço IP público, associação de segurança do grupo de rede e sub-rede do Virtual Network.
8. Define algumas variáveis e tags comuns para o código.

# Introdução ao Backend_Terraform para provisionar Storageaccount terraform para armazenamento o tf.state

Esse código é responsável por criar um recurso de armazenamento no Microsoft Azure para armazenar o arquivo tf.state. Isso é importante para que você possa compartilhar o estado do seu projeto com outras pessoas e manter o controle de versão adequado.

O código utiliza três recursos do Azure: azurerm_resource_group, azurerm_storage_account, e azurerm_storage_container. O primeiro recurso, azurerm_resource_group, cria um grupo de recursos do Azure para armazenar todos os recursos relacionados a este projeto. Em seguida, o recurso azurerm_storage_account cria uma conta de armazenamento para armazenar o arquivo tf.state. Por fim, o recurso azurerm_storage_container cria um contêiner de armazenamento para armazenar o arquivo tf.state.

O código especifica o nome e a localização do grupo de recursos, da conta de armazenamento e do contêiner de armazenamento. Ele também define tags comuns para todos os recursos criados.

# Introdução ao codigo para provisionar á estrategia HPA

Este é um arquivo de configuração do Kubernetes que contém dois objetos HorizontalPodAutoscaler, que utilizam a API version autoscaling/v2.

O primeiro HorizontalPodAutoscaler, chamado `mongodb-hpa`, é utilizado para fazer o autoscaling do deployment `mongodb`. Ele está configurado para manter um mínimo de 1 replica e um máximo de 5 replicas. O autoscaler irá escalar para cima ou para baixo baseado na utilização média de CPU, com uma utilização alvo de 50%.

O segundo HorizontalPodAutoscaler, chamado `api-hpa`, é utilizado para fazer o autoscaling do deployment api. Ele também está configurado para manter um mínimo de 1 replica e um máximo de 5 replicas. Assim como o primeiro autoscaler, ele escala baseado na utilização média de CPU, com uma utilização alvo de 50%.

Para aplicar este arquivo de configuração ao seu cluster do Kubernetes, você pode utilizar o comando `kubectl apply -f <file>.yaml`:

## MongoDB Deployment e Service

O primeiro bloco de código cria um deployment para o MongoDB e um serviço para expor o deployment. O deployment consiste em um único container rodando a imagem mongo:4.4.5, com duas variáveis de ambiente definidas: MONGO_INITDB_ROOT_USERNAME e MONGO_INITDB_ROOT_PASSWORD. O serviço do MongoDB é um serviço ClusterIP, que expõe a porta 27017.

## API Deployment e Service

O segundo bloco de código cria um deployment para a API e um serviço para expor o deployment. O deployment consiste em um único container rodando a imagem devopsguimaraes/api-produto:latest, que consome o banco de dados MongoDB do serviço anterior. O serviço da API é um serviço LoadBalancer, que expõe a porta 80 e tem um nodePort definido como 30000.

## MongoDB e API HorizontalPodAutoscaler

Os dois últimos blocos de código criam duas estratégias de escalonamento automático de pod para lidar com as demandas de tráfego: mongodb-hpa e api-hpa. Ambas são estratégias HorizontalPodAutoscaler e têm como alvo os deployments mongodb e api, respectivamente. Cada uma delas tem um mínimo de 1 pod, um máximo de 5 pods e uma métrica de utilização de CPU média alvo de 50%.

# Introdução ao codigo para provisinar á Pipeline para construção,do push e deploy de uma imagem Docker no Kubernetes

Este pipeline é usado para construir uma imagem Docker, fazer o push para o Docker Hub e, em seguida, implantar a imagem no Kubernetes. É composto por três estágios: Build Image, Push Image e Deploy Kubernetes.

## Build Image

Este estágio constrói a imagem Docker usando o Dockerfile localizado em `./src/Dockerfile`. A imagem é nomeada como `devopsguimaraes/api-produto:${env.BUILD_ID}`, onde `${env.BUILD_ID}` é a ID de compilação exclusiva gerada pelo Jenkins.

## Push Image

Este estágio faz o push da imagem Docker recém-construída para o Docker Hub, usando as credenciais armazenadas em `dockerhub`. A imagem é push para duas tags: latest e `${env.BUILD_ID}`.

## Deploy Kubernetes

Este estágio é responsável por implantar a imagem Docker no Kubernetes. Ele faz o download do arquivo `./k8s/deployment.yaml` e substitui a tag`{{tag}}` pelo valor de `${env.BUILD_ID}`. Em seguida, aplica as alterações no Kubernetes usando o comando `kubectl apply -f ./k8s/deployment`.yaml.

## Credenciais

Este pipeline requer as seguintes credenciais armazenadas no Jenkins:

- `dockerhub`: credenciais para fazer o push da imagem Docker para o Docker Hub
- `kubeconfig`: arquivo de configuração do Kubernetes para implantar as alterações no cluster.

## Pré-requisitos

- Jenkins instalado e configurado para uso com o Kubernetes.
- Cluster Kubernetes configurado e acessível pelo Jenkins.

# Como usar

1.Crie um novo pipeline no Jenkins e cole o código do pipeline.
2.Certifique-se de ter as credenciais dockerhub e kubeconfig armazenadas no Jenkins. 3. Inicie a construção do pipeline e aguarde a conclusão da compilação, push e implantação da imagem Docker no Kubernetes.
