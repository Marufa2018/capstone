node {
    stage('Checking out git repo') {
      echo 'Checkout...'
      checkout scm
    }
    stage('Checking environment') {
      echo 'Checking environment...'
      sh 'git --version'
      echo "Branch: ${env.BRANCH_NAME}"
      sh 'docker -v'
    }
    stage("Linting") {
      echo 'Linting...'
      sh 'tidy -q -e index.html'
    }
    stage('Build Docker Image') {
        sh 'docker build -t mars20/testblueimage blue/.'
        sh 'docker build -t mars20/testgreenimage green/.'
    }
    stage('Push Docker Image') {
        withDockerRegistry([url: "", credentialsId: "dockerhub"]) {
          sh 'docker push mars20/testblueimage'
          sh 'docker push mars20/testgreenimage'
      }
    }
    stage('Deploying to AWS EKS') {
      echo 'Deploying to AWS EKS...'
      dir ('./') {
        withAWS(credentials: 'C3User', region: 'us-east-2') {
            sh "kubectl config current-context"
            sh "kubectl get svc"
        }
      }
    }
}