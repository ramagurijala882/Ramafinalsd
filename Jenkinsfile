pipeline {
    agent any

    environment {
        IMAGE_NAME = "healthcare-app"
        CONTAINER_NAME = "healthcare-container"
        APP_PORT = "3000"  // Exposing this on the host machine
    }

    stages {
        stage('Clone Repo') {
            steps {
                script {
                    echo "Cloning the GitHub Repository..."
                    git branch: 'main', url: 'https://github.com/ramagurijala882/Ramafinalsd.git'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker Image..."
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Security Compliance Check') {
            steps {
                script {
                    echo "Checking for potential security risks..."

                    // Check if the container is running as root (basic security check)
                    echo "Checking for root user in the container..."
                    sh "docker inspect ${IMAGE_NAME} | grep '\"User\": \"\"' && echo '⚠️ Container running as root!' || echo '✅ No root user found!'"

                    // Run Trivy security scan (uncomment the line below if Trivy is installed on your Jenkins instance)
                    // sh "sudo apt install -y trivy"
                    // sh "trivy image ${IMAGE_NAME}"

                    // If Trivy is not allowed or can't be installed, you can skip the scan, and manually handle later.
                    echo "Simulated compliance check completed."
                }
            }
        }

        stage('Stop Old Container') {
            steps {
                script {
                    echo "Stopping and Removing Old Container..."
                    sh """
                        docker stop ${CONTAINER_NAME} || true
                        docker rm ${CONTAINER_NAME} || true
                    """
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    echo "Running Docker Container..."
                    // Map port 80 from the container to port 3000 on the host
                    sh "docker run -d -p ${APP_PORT}:80 --name ${CONTAINER_NAME} ${IMAGE_NAME}"
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
