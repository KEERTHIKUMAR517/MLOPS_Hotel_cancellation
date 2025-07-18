pipeline{
    agent any

    environment {
        VENV_DIR = 'venv'
    }

    stages{
        stage('Cloining github repo to Jenkins'){
            steps{
                script{
                    echo 'Cloining github repo to Jenkins ..........'
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'githubtoken', url: 'https://github.com/KEERTHIKUMAR517/MLOPS_Hotel_cancellation.git']])
                }
            }
        }

    stage('Setting up out venv installing dependencies'){
            steps{
                script{
                    echo 'Setting up out venv installing dependencie ..........'
                    sh ''' 
                    python -m venv ${VENV_DIR}
                    . ${VENV_DIR}/bin/activate
                    pip install --upgrade pip
                    pip install -e .
                    '''
                }
            }
        }
    }
}