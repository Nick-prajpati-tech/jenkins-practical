pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Replace with your actual repository URL
                git credentialsId: 'github-credentials', url: 'https://github.com/Nick-prajpati-tech/jenkins-practical.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image from the Dockerfile in your repository
                    docker.build('my-python-app:latest', '.')
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run the container and test if the app runs
                    docker.image('my-python-app:latest').inside('-v C:/ProgramData/Jenkins/.jenkins/workspace/python:/app') {
                        // Start the app and sleep for a while to allow it to start
                        sh 'python app.py & sleep 10'
                        
                        // Check if the app is accessible
                        sh 'curl -f http://localhost:5000/ || exit 1'  // Exit with error if the app is not reachable
                    }
                }
            }
        }

        stage('Push Docker Image to Registry') {
            steps {
                script {
                    // Push Docker image to DockerHub, using DockerHub credentials
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
