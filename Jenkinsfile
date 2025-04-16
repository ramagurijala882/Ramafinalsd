stage('Vulnerability Scan with Trivy') {
    steps {
        script {
            echo "🔐 Running Trivy for image vulnerability scan..."

            // Check if Trivy is installed using the absolute path
            sh '''
                if [ ! -f /usr/bin/trivy ]; then
                    echo "❌ Trivy is not installed on this machine. Please install it before running the pipeline."
                    exit 1
                fi
            '''

            // Run Trivy image scan
            sh "trivy image ${IMAGE_NAME} || echo '⚠️ Vulnerabilities may exist in the image.'"
        }
    }
}
