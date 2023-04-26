pipeline {
    agent any
    environment {
//         PORT = "85"
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        IMAGE_NAME = "vatsalviven/devops-project"
        DOCKERHUB_REPO = "vatsalviven/fitkart"
        CONTAINER_NAME = "devops-project"
        GIT_REPO = "https://github.com/vivatsal/fitkart.git"
        GIT_BRANCH = "master"
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
                    //sh "sudo docker logout"
                }
            }
        }
        stage('Deploy Docker Image Nginx') {
            steps {
                sh "sudo docker run -it -p 100:80 --name ${CONTAINER_NAME} -d ${IMAGE_NAME}"
            }
        }
        stage('Login') {
            steps {
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
            }
        }
        stage('DockerHub') {
            steps { 
                sh "sudo docker tag ${IMAGE_NAME} ${DOCKERHUB_REPO}:${BUILD_NUMBER}"
                sh "sudo docker push ${DOCKERHUB_REPO}:${BUILD_NUMBER}"
                sh "sudo docker logout"
            }
        }
    }
}
