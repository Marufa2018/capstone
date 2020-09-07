pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        sh 'echo Building...'
      }
    }
    stage('lint') {
      steps {
        sh 'tidy -q -e index.html'
      }
    }
    stage('Build Docker Image') {
      steps {
        sh 'docker build -t mars20/testblueimage blue/.'
        sh 'docker build -t mars20/testgreenimage green/.'
      }
    }
    stage('Push Docker Image') {
      steps {
        withDockerRegistry([url: "", credentialsId: "dockerhub"]) {
          sh 'docker push mars20/testblueimage'
          sh 'docker push mars20/testgreenimage'

        }
      }
    }
    stage('Deployment') {
      steps {
       dir ('./') {
        withAWS(credentials: 'aws', region: 'us-west-2') {
            sh "kubectl config set-cluster minikube --server=https://127.0.0.1:8443 --insecure-skip-tls-verify=true"
            sh "kubectl config set-context minikube --cluster=minikube --user=minikube"
            sh "kubectl config use-context minikube"
            sh "kubectl apply -f blue/blue-controller.json"
            sh "kubectl apply -f green/green-controller.json"
            sh "kubectl apply -f ./blue-green-service.json"
            sh "kubectl get nodes"
            sh "kubectl get pods"
          }
        }
      }
    }
  }
}