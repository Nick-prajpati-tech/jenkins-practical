pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub-credentials') // Use the ID you created in Jenkins
        IMAGE_NAME = "techwithnick/jenkins-project" // Replace with your Docker Hub username and repository
    }

    stages {
        stage('Clone repository') {
            steps {
                // Pull code from the master branch of your GitHub repo
                git branch: 'master', url: 'https://github.com/Nick-prajpati-tech/jenkins-practical.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image using app.py and Dockerfile
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Log in to Docker Hub
                    sh 'echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin'

                    // Push Docker image to Docker Hub
                    sh 'docker push $IMAGE_NAME'
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
