pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-username/my-python-app.git'  // Update this URL with your repo
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('my-python-app:latest')
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run the container and test if it runs
                    docker.image('my-python-app:latest').inside {
                        sh 'python app.py & sleep 5'  // Run the app for 5 seconds to test
                    }
                }
            }
        }

        stage('Push Docker Image to Registry') {
            steps {
                script {
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
