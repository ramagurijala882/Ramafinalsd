pipeline {
    agent any

    environment {
        IMAGE_NAME = "healthcare-app"
        CONTAINER_NAME = "healthcare-container"
        APP_PORT = "3000"
    }

    stages {
        stage('Clone Repo') {
            steps {
                // GitHub Repository URL
                git 'https://github.com/ramagurijala882/Ramafinalsd.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker Image from the Dockerfile
                script {
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Stop Old Container') {
            steps {
                // Stop and Remove any Old Containers
                script {
                    sh """
                        docker stop $CONTAINER_NAME || true
                        docker rm $CONTAINER_NAME || true
                    """
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                // Run the Container on the EC2 instance
                script {
                    sh 'docker run -d -p $APP_PORT:$APP_PORT --name $CONTAINER_NAME $IMAGE_NAME'
                }
            }
        }
    }

    post {
        success {
            echo "🚀 App deployed! Access it at: http://<your-ec2-ip>:${APP_PORT}"
        }
        failure {
            echo "❌ Deployment failed."
        }
    }
}
