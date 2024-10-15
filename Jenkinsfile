pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Clone the GitHub repository in Jenkins workspace using credentials
                git credentialsId: 'github-credentials', url: 'https://github.com/Nick-prajpati-tech/jenkins-practical.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image from the Dockerfile in the Jenkins workspace
                    docker.build('my-python-app:latest', '.')
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run the container and test if the Flask app works
                    docker.image('my-python-app:latest').inside {
                        // Start the Flask app inside the Docker container in the background
                        sh 'python app.py & sleep 10'
                        
                        // Test if the Flask app is accessible at localhost:5000 using curl
                        sh 'curl -f http://localhost:5000/ || exit 1'  // Exit with error if the app is not reachable
                    }
                }
            }
        }

        stage('Push Docker Image to Registry') {
            steps {
                script {
                    // Push Docker image to DockerHub using DockerHub credentials
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        docker.image('my-python-app:latest').push()
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
