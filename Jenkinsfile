pipeline {
    agent any
    
    stages {
        stage('Pull Docker Image') {
            steps {
                script {
                    // Pull the Flask Hello World image from Docker Hub
                    sh 'docker pull tullyrankin/flask-hello-world'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Flask app in a Docker container
                    sh 'docker run -d -p 5000:5000 tullyrankin/flask-hello-world'
                }
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
            sh 'docker rm -f $(docker ps -aq --filter "ancestor=tullyrankin/flask-hello-world")'
        }

        success {
            echo 'Flask app built and running successfully!'
        }

        failure {
            echo 'Build failed. Please check the logs.'
        }
    }
}
