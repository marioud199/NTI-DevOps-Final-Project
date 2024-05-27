pipeline {
    agent any 

    environment {
        REPO_SERVER = "730335618715.dkr.ecr.eu-west-1.amazonaws.com/backend_repo"
        REPO_NAME_BACKEND = "${REPO_SERVER}:backend"
        REPO_NAME_FRONTEND = "${REPO_SERVER}:frontend"
        IMAGE_VERSION = "${BUILD_NUMBER}"
        AWS_REGION = 'eu-west-1'
    }

    stages {
        stage("start ........") {
            steps {
                script {
                    echo "starting the project ......"
                }
                }
        }

        stage("build image") {
            steps {
                script {
                    echo "building docker images ..."
                   {
                        sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_URL}"
                        sh "docker build app/backend/. -t ${REPO_NAME_BACKEND}-${IMAGE_VERSION}"
                        sh "docker push ${REPO_NAME_BACKEND}-${IMAGE_VERSION}"
                        sh "docker build app/frontend/. -t ${REPO_NAME_FRONTEND}-${IMAGE_VERSION}"
                        sh "docker push ${REPO_NAME_FRONTEND}-${IMAGE_VERSION}"
                    }
                }
            }
        }

        stage("change image version") {
            steps {
                script {
                    echo "change image version .."
                    sh "sed -i \"s|image:.*|image: ${REPO_NAME_BACKEND}-${IMAGE_VERSION}|g\" k8s/back.yaml"
                    sh "sed -i \"s|image:.*|image: ${REPO_NAME_FRONTEND}-${IMAGE_VERSION}|g\" k8s/front.yaml"
                }
            }
        }

        stage('Deploy to eks cluster') {
            // environment {
            //     AWS_ACCESS_KEY_ID = credentials("aws_access_key_id")
            //     AWS_SECRET_ACCESS_KEY = credentials("aws_secret_access_key")
            // }
            steps {
                echo 'Deploying to eks cluster ... '
                withCredentials([file(credentialsId:'kubeconfig', variable:'KUBECONFIG')]){
                    script{
                        sh 'kubectl apply -f k8s'
                    }
                }
            }
        }
        stage("THE END") {
            steps {
                script {
                    echo "finishing  the project ......"
                }
                }
        }
    }
}
