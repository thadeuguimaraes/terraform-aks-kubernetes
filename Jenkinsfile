pipeline {
    agent any

    stages {
        stage ('Build Image') {
            steps {
                scripts {
                    dockerapp = docker.build("devopsguimaraes/api-produto", '-f ./src/Dockerfile ./src')
                }
            }
        }
    }
}