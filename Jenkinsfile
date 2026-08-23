pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
        EKS_CLUSTER_NAME   = 'shopsphere-eks'

        FRONTEND_REPO      = 'shopsphere/frontend'
        USER_SERVICE_REPO  = 'shopsphere/user-service'
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

        stage('Build Docker Images') {
            steps {
                sh '''
                    docker build \
                      -t shopsphere-frontend:${BUILD_NUMBER} \
                      ./app/frontend

                    docker build \
                      -t shopsphere-user-service:${BUILD_NUMBER} \
                      ./app/user-service
                '''
            }
        }

        stage('Push Images to ECR') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'aws-credentials',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    )
                ]) {
                    sh '''
			AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

                        ECR_REGISTRY=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com

                        aws ecr get-login-password \
                          --region ${AWS_DEFAULT_REGION} \
                        | docker login \
                          --username AWS \
                          --password-stdin ${ECR_REGISTRY}

                        docker tag \
                          shopsphere-frontend:${BUILD_NUMBER} \
                          ${ECR_REGISTRY}/${FRONTEND_REPO}:${BUILD_NUMBER}

                        docker tag \
                          shopsphere-user-service:${BUILD_NUMBER} \
                          ${ECR_REGISTRY}/${USER_SERVICE_REPO}:${BUILD_NUMBER}

                        docker push \
                          ${ECR_REGISTRY}/${FRONTEND_REPO}:${BUILD_NUMBER}

                        docker push \
                          ${ECR_REGISTRY}/${USER_SERVICE_REPO}:${BUILD_NUMBER}
                    '''
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'aws-credentials',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    )
                ]) {
                    sh '''
			AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

                        ECR_REGISTRY=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com

                        aws eks update-kubeconfig \
                          --region ${AWS_DEFAULT_REGION} \
                          --name ${EKS_CLUSTER_NAME}

                        helm upgrade --install shopsphere \
                          ./helm/shopsphere \
                          --namespace shopsphere \
                          --create-namespace \
                          --set frontend.image.repository=${ECR_REGISTRY}/${FRONTEND_REPO} \
                          --set frontend.image.tag=${BUILD_NUMBER} \
                          --set userService.image.repository=${ECR_REGISTRY}/${USER_SERVICE_REPO} \
                          --set userService.image.tag=${BUILD_NUMBER}
                    '''
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                    kubectl get pods -n shopsphere
                    kubectl get svc -n shopsphere
                    kubectl get ingress -n shopsphere
                '''
            }
        }
    }

    post {
        success {
            echo 'ShopSphere CI/CD pipeline completed successfully.'
        }

        failure {
            echo 'ShopSphere CI/CD pipeline failed.'
        }

        always {
            echo 'Pipeline execution completed.'
        }
    }
}
