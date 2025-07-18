pipeline{
    agent any

    stages{
        stage('Cloining github repo to Jenkins'){
            steps{
                script{
                    echo 'Cloining github repo to Jenkins ..........'
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'githubtoken', url: 'https://github.com/KEERTHIKUMAR517/MLOPS_Hotel_cancellation.git']])
                }
            }
        }
    }
}