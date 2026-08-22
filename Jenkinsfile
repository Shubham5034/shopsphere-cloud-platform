pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Checkout completed'
            }
        }

        stage('Build') {
            steps {
                echo 'Build stage'
            }
        }

        stage('Test') {
            steps {
                echo 'Test stage'
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Docker build stage'
            }
        }

        stage('Push to ECR') {
            steps {
                echo 'Push to ECR stage'
            }
        }

        stage('Deploy to EKS') {
            steps {
                echo 'Deploy to EKS stage'
            }
        }
    }

    post {
        success {
            echo 'Pipeline successful'
        }

        failure {
            echo 'Pipeline failed'
        }

        always {
            echo 'Pipeline completed'
        }
    }
}
