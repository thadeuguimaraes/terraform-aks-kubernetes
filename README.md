# Introdução ao Backend Storageaccount terraform para armazenamento o tf.state

Esse código é responsável por criar um recurso de armazenamento no Microsoft Azure para armazenar o arquivo tf.state. Isso é importante para que você possa compartilhar o estado do seu projeto com outras pessoas e manter o controle de versão adequado.

O código utiliza três recursos do Azure: azurerm_resource_group, azurerm_storage_account, e azurerm_storage_container. O primeiro recurso, azurerm_resource_group, cria um grupo de recursos do Azure para armazenar todos os recursos relacionados a este projeto. Em seguida, o recurso azurerm_storage_account cria uma conta de armazenamento para armazenar o arquivo tf.state. Por fim, o recurso azurerm_storage_container cria um contêiner de armazenamento para armazenar o arquivo tf.state.

O código especifica o nome e a localização do grupo de recursos, da conta de armazenamento e do contêiner de armazenamento. Ele também define tags comuns para todos os recursos criados.

# Introdução á estrategia HPA

Este é um código YAML para criar um ambiente Kubernetes com dois serviços: um banco de dados MongoDB e uma API RESTful que consome esse banco de dados. Além disso, o código inclui duas estratégias de escalonamento automático de pod para lidar com as demandas de tráfego: mongodb-hpa e api-hpa.

Em seguida, você pode explicar o que cada parte do código faz, seguindo a ordem em que as informações aparecem. Por exemplo:

## MongoDB Deployment e Service

O primeiro bloco de código cria um deployment para o MongoDB e um serviço para expor o deployment. O deployment consiste em um único container rodando a imagem mongo:4.4.5, com duas variáveis de ambiente definidas: MONGO_INITDB_ROOT_USERNAME e MONGO_INITDB_ROOT_PASSWORD. O serviço do MongoDB é um serviço ClusterIP, que expõe a porta 27017.

## API Deployment e Service

O segundo bloco de código cria um deployment para a API e um serviço para expor o deployment. O deployment consiste em um único container rodando a imagem devopsguimaraes/api-produto:latest, que consome o banco de dados MongoDB do serviço anterior. O serviço da API é um serviço LoadBalancer, que expõe a porta 80 e tem um nodePort definido como 30000.

## MongoDB e API HorizontalPodAutoscaler

Os dois últimos blocos de código criam duas estratégias de escalonamento automático de pod para lidar com as demandas de tráfego: mongodb-hpa e api-hpa. Ambas são estratégias HorizontalPodAutoscaler e têm como alvo os deployments mongodb e api, respectivamente. Cada uma delas tem um mínimo de 1 pod, um máximo de 5 pods e uma métrica de utilização de CPU média alvo de 50%.

# Introdução a instalação do jenkins num namespace do Cluster AKS

1.Adicione o repositório do Jenkins ao Helm:
helm repo add jenkins https://charts.jenkins.io
helm repo update
2.Instale o Jenkins no namespace desejado:
helm upgrade --install myjenkins jenkins/jenkins --namespace <namespace>
3.Obtenha a senha do usuário 'admin' executando:
kubectl exec --namespace <namespace> -it svc/myjenkins -c jenkins -- /bin/cat /run/secrets/chart-admin-password && echo
4.Obtenha a URL do Jenkins executando os seguintes comandos no mesmo shell:
echo http://127.0.0.1:8080
5.Faça login com a senha do passo 3 e o nome de usuário 'admin'.
6.Configure o realm de segurança e a estratégia de autorização.
7.Use a Configuração do Jenkins como código, especificando configScripts no arquivo values.yaml.
8.Use a Configuração do Jenkins como código, especificando configScripts no arquivo values.yaml.
Documentação: http:///configuration-as-code
Exemplos: https://github.com/jenkinsci/configuration-as-code-plugin/tree/master/demos
9.Em seguida, atualize o release do Helm usando os valores definidos em values.yaml com o comando:
helm upgrade --install -f values.yaml myjenkins jenkins/jenkins --namespace <namespace>
10.Acesse o Jenkins através do IP público gerado pelo serviço LoadBalancer:
kubectl get svc --namespace <namespace> myjenkins --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}"
Faça login novamente com as informações do passo 5.
Para mais informações sobre a execução do Jenkins no Kubernetes, visite:
https://cloud.google.com/solutions/jenkins-on-container-engine
Para mais informações sobre a Configuração do Jenkins como código, visite:
https://jenkins.io/projects/jcasc/
