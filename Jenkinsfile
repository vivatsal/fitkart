pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        IMG = "vatsalviven/devops-project"
        IMAGE_NAME = "vatsalviven/devops-project${BUILD_NUMBER}"
        DOCKERHUB_REPO = "vatsalviven/fitkart"
        CONTAINER_NAME = "devops-project"
        GIT_REPO = "https://github.com/vivatsal/fitkart.git"
        GIT_BRANCH = "master"
        VALUE = '1'
    }
    stages {
        stage('Checkout Git') {
            steps {
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }
        stage('Build Image') {
            steps {
                script {
                    // sh "sudo docker kill ${CONTAINER_NAME}|| true"
                    sh "sudo docker rm ${CONTAINER_NAME}|| true"
                    sh "sudo docker build . -t ${IMAGE_NAME}"
                    sh "sudo docker logout"
                }
            }
        }
        stage('Deploy Nginx') {
            steps {
                sh "sudo docker run -it -p 100:80 --name ${CONTAINER_NAME} -d ${IMAGE_NAME}"
            }
        }
        stage('Login Dockerhub') {
            steps {
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | sudo docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
            }
        }
        stage('DockerHub Push') {
            steps { 
                sh "sudo docker tag ${IMAGE_NAME} ${DOCKERHUB_REPO}:${BUILD_NUMBER}"
                sh "sudo docker push ${DOCKERHUB_REPO}:${BUILD_NUMBER}"
                sh "sudo docker logout"
            }
        }
        stage('Clear Image'){
            steps {
                // sh "sudo docker rmi ${IMG}${BUILD_NUMBER.toInteger()-1}"
                // sh "sudo docker rmi -f ${DOCKERHUB_REPO}:${BUILD_NUMBER}"
            }
        }
    }
}
