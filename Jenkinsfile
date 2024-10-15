pipeline {
    agent any

    environment {
        // Define any environment variables such as registry URL or credentials
        DOCKER_REGISTRY = 'techwithnick'
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone GitHub repository using credentials
                git credentialsId: 'github-credentials', url: 'https://github.com/Nick-prajpati-tech/jenkins-practical.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image from the Dockerfile
                    def image = docker.build("${DOCKER_REGISTRY}/my-python-app:latest")
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run the Docker container and test if the app works
                    docker.image("${DOCKER_REGISTRY}/my-python-app:latest").inside {
                        // Start the Flask app inside Docker container and sleep to let it start
                        sh 'python app.py & sleep 10'
                        
                        // Test the app with curl (checks if Flask is running on port 5000)
                        sh 'curl -f http://localhost:5000/ || exit 1'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Log into DockerHub and push the image
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        docker.image("${DOCKER_REGISTRY}/my-python-app:latest").push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Example deploy step (could be running the container on a server or Kubernetes cluster)
                    // Here we can use SSH to deploy it to a remote server or use Kubernetes, etc.
                    echo 'Deploying the app...'
                    // You can include steps to deploy the container on a server or start it
                }
            }
        }
    }

    post {
        success {
            echo 'Project run successfully. Sending notification...'
            // Add notification, like sending an email or Slack message here
        }
        failure {
            echo 'Project failed. Investigate the issue...'
            // Handle the failure case here
        }
        always {
            echo 'Pipeline finished.'
        }
    }
}
