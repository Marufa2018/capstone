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
    stage('Building image blue') {
	    echo 'Building Docker image blue...'
      withDockerRegistry([url: "", credentialsId: "dockerhub"]){
	     	sh "sudo docker build -t ${registry1} blue/."
	     	sh "sudo docker tag ${registry1} ${registry1}"
	     	sh "sudo docker push ${registry1}"
      }
    }
    stage('Building image green') {
	    echo 'Building Docker image green...'
      withDockerRegistry([url: "", credentialsId: "dockerhub"]) {
	     	sh "sudo docker build -t ${registry2} green/."
	     	sh "sudo docker tag ${registry2} ${registry2}"
	     	sh "sudo docker push ${registry2}"
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