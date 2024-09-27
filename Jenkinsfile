pipeline {
    agent {
        docker { image 'node:20.17.0-alpine3.20' }
    }

    environment {
        DOCKER_PATH = "/var/jenkins_home/bin"
        PATH = "${DOCKER_PATH}:${env.PATH}"
    }

}
//     stages {
//         stage('Install Docker') {
//             steps {
//                 script {
//                     sh '''
//                         curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz
//                         tar xzvf docker-17.04.0-ce.tgz
//                         mkdir -p $HOME/bin
//                         mv docker/docker $HOME/bin/docker
//                         rm -r docker docker-17.04.0-ce.tgz
//                         export PATH=$HOME/bin:$PATH
//                         docker --version
//                     '''
//                 }
//             }
//         }

//         stage('Pull Docker Image') {
//             steps {
//                 script {
//                     // Pull the Flask Hello World image from Docker Hub
//                     git url: 'https://github.com/ItzikSdev/python-flask', branch: 'main'
//                 }
//             }
//         }
        
//         stage('Build Docker Image') {
//             steps {
//                 // Build the Docker image using the Dockerfile in the repository
//                 sh '''
//                 docker ps
//                 docker build -t itziksdev/python-flask .
//                 '''
//             }
//         }

//         stage('Run Docker Container') {
//             steps {
//                 // Run the Docker container
//                 sh 'docker run -d -p 443:443 itziksdev/python-flask'
//             }
//         }

//         stage('Test Application') {
//             steps {
//                 script {
//                     // Test if the Flask app is running correctly
//                     sh 'curl https://localhost:443'
//                 }
//             }
//         }
//     }

//     post {
//         always {
//             echo 'Pipeline finished.'
//         }
//     }
// }
