pipeline {
    agent any

    stages {
        stage ('Build') {
            steps {
                script {
                    dockerapp = docker.build("devopsguimaraes/api-produto", '-f ./src/Dockerfile ./src')
                }
            }
        }
    }
}