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
                git 'https://github.com/ramagurijala882/Ramafinalsd.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Stop Old Container') {
            steps {
                sh """
                    docker stop $CONTAINER_NAME || true
                    docker rm $CONTAINER_NAME || true
                """
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker run -d -p $APP_PORT:$APP_PORT --name $CONTAINER_NAME $IMAGE_NAME'
            }
        }
    }

    post {
        success {
            echo "🚀 App deployed! Access it at: http://<your-EC2-IP>:${APP_PORT}"
        }
        failure {
            echo "❌ Deployment failed."
        }
    }
}
