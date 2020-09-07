node {
    def registry1 = 'mars20/testblueimage'
    def registry2 = 'mars20/testgreenimage'
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
        withAWS(credentials: 'C#User', region: 'us-west-2') {
            sh "aws eks --region us-west-2 update-kubeconfig --name pod"
            sh "kubectl apply -f blue/blue-controller.json"
            sh "kubectl apply -f green/green-controller.json"
            sh "kubectl apply -f ./blue-green-service.json"
            sh "kubectl get nodes"
            sh "kubectl get pods"
        }
      }
    }
}