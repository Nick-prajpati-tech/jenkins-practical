pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub-credentials') // Use the ID you created in Jenkins
        IMAGE_NAME = "techwithnick/jenkins-project" // Replace with your Docker Hub username and repository
    }

    stages {
        stage('Clone repository') {
            steps {
                // Pull code from your GitHub repo
                git branch: 'main', url: 'https://github.com/Nick-prajpati-tech/jenkins-practical.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image using app.py and Dockerfile
                    bat "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Log in to Docker Hub
                    bat "echo %DOCKER_HUB_CREDENTIALS_PSW% | docker login -u %DOCKER_HUB_CREDENTIALS_USR% --password-stdin"

                    // Push Docker image to Docker Hub
                    bat "docker push ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
