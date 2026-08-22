pipeline {
    agent any
    
    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
    } 
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

	stage('AWS Authentication') {
    steps {
        withCredentials([
            usernamePassword(
                credentialsId: 'aws-credentials',
                usernameVariable: 'AWS_ACCESS_KEY_ID',
                passwordVariable: 'AWS_SECRET_ACCESS_KEY'
            )
        ]) {
            sh '''
                aws sts get-caller-identity
            '''
        }
    }
}

        stage('Build Frontend Image') {
            steps {
                sh '''
                  docker build \
                    -t shopsphere-frontend:${BUILD_NUMBER} \
                    ./app/frontend
                '''
            }
        }

        stage('Build User Service Image') {
            steps {
                sh '''
                  docker build \
                    -t shopsphere-user-service:${BUILD_NUMBER} \
                    ./app/user-service
                '''
            }
        }

        stage('Verify Images') {
            steps {
                sh '''
                  docker images | grep shopsphere
                '''
            }
        }
    }

    post {
        success {
            echo 'Docker images built successfully.'
        }

        failure {
            echo 'Docker build failed.'
        }

        always {
            echo 'Pipeline completed.'
        }
    }
}


