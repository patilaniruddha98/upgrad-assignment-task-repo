pipeline{
    //agent any
    agent { label 'app'}
    options{
        buildDiscarder(logRotator(daysToKeepStr: '15'))
        disableConcurrentBuilds()
        timeout(time: 5, unit: 'MINUTES')
    }
    
    environment{
        ECS_CLUSTER = "hello-app"
        ENVIRONMENT = "global"
        CONTAINER_NAME = "Hello_container"
    }
    stages{
       stage('Git Checkout'){
        steps{
            checkout scm
        }
       } 
       stage('Build and Push'){
        steps{
            sh "docker stop ${CONTAINER_NAME}"
            sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 186313464150.dkr.ecr.us-east-1.amazonaws.com"
            sh "docker build -t 186313464150.dkr.ecr.us-east-1.amazonaws.com/assignment-2-upgrad:v${BUILD_NUMBER} ."
            sh "docker push 186313464150.dkr.ecr.us-east-1.amazonaws.com/assignment-2-upgrad:v${BUILD_NUMBER}"
        }
       }
       stage('Deploy Stage'){
        steps{
            sh '''
            IMAGE="186313464150.dkr.ecr.us-east-1.amazonaws.com/assignment-2-upgrad:v${BUILD_NUMBER}"
            docker pull $IMAGE
            docker run -itd --name ${CONTAINER_NAME} -p 8080:8081 $IMAGE
            '''
        }
       } 
    }
    post{
        always{
            sh "echo running final steps"
        }
    }

}