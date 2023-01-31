pipeline{
    agent { label 'app'}
    options{
        buildDiscarder(logRotator(daysToKeepStr: '15'))
        disableConcurrentBuilds()
        timeout(time: 5, unit: 'MINUTES')
    }
    
    environment{
        ECS_CLUSTER = "hello-app"
        ENVIRONMENT = "global"
        CONTAINER_NAME = "my_container"
    }
    stages{
       stage('Git Checkout'){
        steps{
            checkout scm
        }
       } 
       stage('Build and Push'){
        steps{
            sh '''
            if [ "$(docker ps -q -f name=${CONTAINER_NAME})" ]
            then
                docker rm --force ${CONTAINER_NAME}
            fi

            aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 191651552348.dkr.ecr.us-east-1.amazonaws.com
            docker build -t 191651552348.dkr.ecr.us-east-1.amazonaws.com/upgrad-assignment-2:v${BUILD_NUMBER} .
            docker push 191651552348.dkr.ecr.us-east-1.amazonaws.com/upgrad-assignment-2:v${BUILD_NUMBER}
            '''
             
        }
       }
       stage('Deploy Stage'){
        steps{
            sh '''
            IMAGE="191651552348.dkr.ecr.us-east-1.amazonaws.com/upgrad-assignment-2:v${BUILD_NUMBER}"
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
