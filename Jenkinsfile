def service_name = 'my-flask-app'
def dockerhub_user = "itziksavaia"
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