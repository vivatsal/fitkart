pipeline {
    agent any
    environment {
//         PORT = "85"
//         DOCKERHUB_CREDENTIAL_ID = "dockerhub"
        IMAGE_NAME = "devops-project-image"
        CONTAINER_NAME = "devops-project"
        GIT_REPO = "https://github.com/vivatsal/fitkart.git"
        GIT_BRANCH = "main"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }
        stage('Build') {
            steps {
                script {
                    sh "sudo docker kill ${CONTAINER_NAME}|| true"
                    sh "sudo docker rm ${CONTAINER_NAME}|| true"
                    sh "sudo docker build . -t ${IMAGE_NAME}"
                }
            }
        }
        stage('Deploy Docker Image') {
            steps {
                sh "sudo docker run -it -p 100:80 --name ${CONTAINER_NAME} -d ${IMAGE_NAME}"
            }
        }
    }
}
