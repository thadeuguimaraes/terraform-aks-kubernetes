pipeline {
    agent any

    stages {
        stage ('Build Image') {
            steps {
                script {
                    dockerapp = docker.build("devopsguimaraes/api-produto:${env.BUILD_ID}", '-f ./src/Dockerfile ./src') 
                }
            }
        }

        stage ('Push Image') {
            steps {
                script {
                    docker.whithRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        dockerapp.push('latest')
                        dockerapp.push("${env.BUILD_ID}")
                    }
                }
            }
        }
    }
}