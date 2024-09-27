pipeline {
    agent any
    
    stages {
        stage('Pull Docker Image') {
            steps {
                script {
                    // Pull the Flask Hello World image from Docker Hub
                    git url: 'https://github.com/ItzikSdev/python-flask', branch: 'main'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image using the Dockerfile in the repository
                sh 'docker build -t ItzikSdev/python-flask .'
            }
        }

        stage('Run Docker Container') {
            steps {
                // Run the Docker container
                sh 'docker run -d -p 5000:5000 ItzikSdev/python-flask'
            }
        }

        stage('Test Application') {
            steps {
                script {
                    // Test if the Flask app is running correctly
                    sh 'curl http://localhost:5000'
                }
            }
        }
    }

    post {
        always {
            // Clean up any running containers after the build
            sh 'docker rm -f $(docker ps -aq --filter "ancestor=ItzikSdev/python-flask")'
        }

        success {
            echo 'Flask app built and running successfully!'
        }

        failure {
            echo 'Build failed. Please check the logs.'
        }
    }
}
