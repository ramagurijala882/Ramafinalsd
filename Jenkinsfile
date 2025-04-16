pipeline {
    agent any

    environment {
        GITHUB_TOKEN = credentials('github-personal-access-token')
        IMAGE_NAME = "healthcare-app"
        CONTAINER_NAME = "healthcare-container"
        APP_PORT = "3000"  // Exposing this on the host machine
    }

    stages {
        stage('Clone Repo') {
            steps {
                script {
                    echo "📥 Cloning the GitHub Repository..."
                    git branch: 'main', url: 'https://github.com/ramagurijala882/Ramafinalsd.git'
                }
            }
        }

        stage('Secret Scanning with GitLeaks') {
            steps {
                script {
                    echo "🔍 Running GitLeaks for secret scanning..."

                    // Install GitLeaks if not already installed
                    sh '''
                        if ! command -v gitleaks &> /dev/null; then
                            curl -sSL https://github.com/gitleaks/gitleaks/releases/latest/download/gitleaks-linux-amd64 -o gitleaks
                            chmod +x gitleaks
                            sudo mv gitleaks /usr/local/bin/
                        fi
                    '''

                    // Run GitLeaks scan
                    sh "gitleaks detect --source . --report-path gitleaks-report.json || echo '⚠️ Secrets may have been found. Check report.'"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "🐳 Building Docker Image..."
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Vulnerability Scan with Trivy') {
            steps {
                script {
                    echo "🔐 Running Trivy for image vulnerability scan..."

                    // Use already-installed Trivy
                    sh '''
                        if ! command -v trivy &> /dev/null; then
                            echo "❌ Trivy is not installed. Please install it manually on the EC2 instance."
                            exit 1
                        fi
                    '''

                    // Run Trivy image scan
                    sh "trivy image ${IMAGE_NAME} || echo '⚠️ Vulnerabilities may exist in the image.'"
                }
            }
        }

        stage('Basic Security Compliance Check') {
            steps {
                script {
                    echo "🛡️ Checking for basic container security compliance..."

                    // Check if container runs as root
                    echo "Checking for root user in the container..."
                    sh "docker inspect ${IMAGE_NAME} | grep '\"User\": \"\"' && echo '⚠️ Container running as root!' || echo '✅ No root user found!'"
                }
            }
        }

        stage('Stop Old Container') {
            steps {
                script {
                    echo "🛑 Stopping and Removing Old Container..."
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
                    echo "🚀 Running Docker Container..."
                    sh "docker run -d -p ${APP_PORT}:80 --name ${CONTAINER_NAME} ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful! Visit: http://<your-ec2-ip>:${APP_PORT}"
        }
        failure {
            echo "❌ Deployment failed. Check logs and scan reports."
        }
    }
}
