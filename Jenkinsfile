pipeline {
  agent {
    kubernetes {
      label "jenkins-slave"
      defaultContainer 'kubectl'
      yaml """
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: kaniko-warmer
            image: gcr.io/kaniko-project/warmer:latest
            args: ["--cache-dir=/cache", "--image=python:latest"]
            resources:
              requests:
                memory: "512Mi"
                cpu: "250m"
              limits:
                memory: "1Gi"
                cpu: "500m"
            volumeMounts:
            - name: kaniko-cache
              mountPath: /cache
          - name: kubectl
            image: bitnami/kubectl:latest
            command:
            - cat
            tty: true
            volumeMounts:
            - name: workspace-volume
              mountPath: /home/jenkins/agent
              readOnly: false
          volumes:
          - name: kaniko-secret
            secret:
              secretName: kaniko-secret
          - name: kaniko-cache
            emptyDir: {}
          - name: workspace-volume
            emptyDir: {}
      """
    }
  }
  stages {
    stage('Deploy to Kubernetes') {
      steps {
        container('kubectl') {
          script {
            def deployment = """
              apiVersion: apps/v1
              kind: Deployment
              metadata:
                name: flask-app
              spec:
                replicas: 1
                selector:
                  matchLabels:
                    app: flask-app
                template:
                  metadata:
                    labels:
                      app: flask-app
                  spec:
                    containers:
                    - name: flask-app
                      image:  itziksavaia/my-flask-app:latest
                      ports:
                      - containerPort: 5000
              ---
              apiVersion: v1
              kind: Service
              metadata:
                name: flask-app-service
              spec:
                selector:
                  app: flask-app
                ports:
                  - protocol: TCP
                    port: 443
                    targetPort: 5000
                type: LoadBalancer
            """
            writeFile file: 'flask-deployment.yaml', text: deployment
            sh 'kubectl apply -f flask-deployment.yaml'
          }
        }
      }
    }
  }
}

def service_name = 'python-flask'
def dockerhub_user = "itziksavaia/my-flask-app"
def image_repository = "${dockerhub_user}/${service_name}"

pipeline {
  agent {
    kubernetes {
      label "jenkins-slave-${service_name}"
      defaultContainer 'podman'
      yaml """
metadata:
  namespace: default
  labels:
    some-label: some-label-value
spec:
  containers:
  - name: podman
    image: quay.io/podman/stable
    command:
      - cat
    tty: true
    securityContext:
      privileged: true
      capabilities:
        add:
          - SYS_ADMIN
  - name: helm
    image: alpine/helm
    command:
      - cat
    tty: true
"""
    }
  }
  stages
  {
    stage('Build')
    {
      steps
      {
        sh "podman login docker.io --username ${dockerhub_user} --password your_dockerhub_password"
        sh "podman buildx build --no-cache --platform linux/amd64 -f Dockerfile -t ${image_repository}:${env.BUILD_NUMBER} ."
      }
    }
    stage('Push') { steps { sh "podman push ${image_repository}:${env.BUILD_NUMBER}" } }
    stage('Deploy')
    {
      steps
      {
        container('helm')
        {
          script
          {
              sh "helm upgrade --install ${service_name} helm-chart/${service_name} --set fullnameOverride=${service_name} --set image.repository=${image_repository},image.tag=${env.BUILD_NUMBER} --namespace myapps --create-namespace --wait"
          }
        }
      }
    }
  }
}