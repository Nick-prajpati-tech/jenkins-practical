pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'techwithnick'  // Your DockerHub username
        DOCKER_IMAGE = 'my-python-app:latest'        // Image name and tag
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone your GitHub repository in Jenkins workspace
                git credentialsId: 'github-credentials', url: 'https://github.com/Nick-prajpati-tech/jenkins-practical.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image from the Dockerfile located in Jenkins workspace
                    def image = docker.build("${DOCKER_REGISTRY}/${DOCKER_IMAGE}")
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // For Windows, you must adjust the path to Docker's expected format
                    def dockerWorkDir = sh(script: "echo /$(echo ${WORKSPACE} | sed 's/C:/c/;s/\\\\/\\//g')", returnStdout: true).trim()
                    
                    // Run the container and test if the app works
                    docker.image("${DOCKER_REGISTRY}/${DOCKER_IMAGE}").inside("--workdir ${dockerWorkDir}") {
                        // Start the Flask app inside the Docker container
                        sh 'python app.py & sleep 10'
                        
                        // Check if the Flask app is accessible at localhost:5000
                        sh 'curl -f http://localhost:5000/ || exit 1'  // Exit with error if the app is not reachable
                    }
                }
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    // Push Docker image to DockerHub, using DockerHub credentials
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        docker.image("${DOCKER_REGISTRY}/${DOCKER_IMAGE}").push()
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Docker image successfully pushed to DockerHub.'
        }
        failure {
            echo 'Pipeline failed. Investigate the issue...'
        }
        always {
            echo 'Pipeline finished.'
        }
    }
}
