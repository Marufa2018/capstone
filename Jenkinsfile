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
        sh 'docker build -t mars20/testblueimage .'
        sh 'docker build -t mars20/testgreenimage .'
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
        withAWS(credentials: "aws") {
          sh 'kubectl apply -f ./blue-controller.json'
          sh 'kubectl apply -f ./green-controller.json'
          sh 'kubectl apply -f ./blue-green-service.json'
        }
      }
    }
  }
}