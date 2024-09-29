pipeline {
   agent {
        docker { image 'python:3.9.20' }
    }

     stages {
        stage('Test') {
            steps {
                sh 'python3 --version'
            }
        }
    }
}