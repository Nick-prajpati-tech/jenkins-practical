pipeline {
    agent any

    environment {
        IMAGE_NAME = "techwithnick/jenkins-project" // Replace with your Docker Hub username and repository
        DOCKER_USERNAME = "techwithnick" // Replace with your Docker Hub username
        DOCKER_PASSWORD = "Niraj@333" // Replace with your Docker Hub password
    }

    stages {
        stage('Clone repository') {
            steps {
                // Pull code from your GitHub repo
                git branch: 'master', url: 'https://github.com/Nick-prajpati-tech/jenkins-practical.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image using app.py and Dockerfile
                    bat 'docker build -t %IMAGE_NAME% .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Log in to Docker Hub
                    bat 'echo %DOCKER_PASSWORD% | docker login -u %DOCKER_USERNAME% --password-stdin'

                    // Push Docker image to Docker Hub
                    bat 'docker push %IMAGE_NAME%'
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
