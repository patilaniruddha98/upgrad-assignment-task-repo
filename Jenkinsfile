pipeline{
    agent any

    stages{
        stage('Git Pull') {
            steps {
                sh "echo Hello i am second stage"
            }
        }

        
        stage('second stage'){
            steps{
                sh "echo Hello i am second stage"
                sh "echo running in stage 2 "
                sh "ls"
            }
           
        }    
        }
    post{
        always{
            sh "echo final stage"
        }
    }
}
