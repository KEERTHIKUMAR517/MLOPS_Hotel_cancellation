pipeline{
    agent any

    environment {
        VENV_DIR = 'venv'
        GCP_PROJECT = 'dynamic-concept-466112-p0'
        GCLOUD_PATH = '/var/jenkins_home/google-cloud-sdk/bin'
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
    stage('Building and Pushing Dokcer Image to GCR'){
            steps{
                withCredentials([file(credentialsId: 'gcp-key', variable : 'GOOGLE_APPLICATION_CREDENTIALS')])
                    script{
                        echo 'Building and Pushing Docker Imageto GCR.........'
                        sh '''
                        export PATH=$PATH:${GCLOUD_PATH}

                        gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}

                        gcloud conf set project ${GCP_PROJECT}

                        gcloud auth configure-docker --quiet 

                        docker build -t gcr.io/${GCP_PROJECT}/ml-project:latest .

                        docker home -t gcr.io/${GCP_PROJECT}/ml-project:latest

                        '''
                    } 
                
            }
        }
    }
}