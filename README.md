## Capstone- Cloud DevOps

Github repository link: https://github.com/Marufa2018/capstone

## Set Up Pipeline

* Create Github repository with project code.
* Use image repository to store Docker images

## Build Docker Container

* Execute linting step in code pipeline
* Build a Docker container in a pipeline

## Successful Deployment

* The Docker container is deployed to a Kubernetes cluster
* Use Blue/Green Deployment or a Rolling Deployment successfully

### Steps to implement the capstone project

1. Provision an EC2 instance on AWS
2. Intall Jenkins
    sudo apt-getupdate
    sudo aptinstall-ydefault-jdk
    wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key| sudo apt-keyadd-
    sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stablebinary/ >/etc/apt/sources.list.d/jenkins.list'
    sudo apt-getupdate
    sudo apt-getinstall-y jenkins
    sudo apt install tidy
 3. Configure Jenkins with all the necessary plugins
    * AWS
    * Blue Ocean
4. Create a repository on GitHub
5. Configure Jenkins to communicate with AWS and Docker
6. Create an k8s cluster on EKS 
    * ./eks_cluster.sh
7. Create different stages in the Jenkinsfile
8. Make sure that you run
    aws configure
9. Make sure that the user which you use to login to Jenkins server has sudo privileges otherwise you will get errors with docker commands.
    Once done then simply follow the below
    *  ./run_docker.sh (For the blue image)
    * ./upload_docker.sh (upload the blue image to docker hub)
    * ./run_docker.sh (For the green image)
    * ./upload_docker.sh (upload the green image to docker hub)

    Ensure EKS is running # eksctl get clusters

    * kubectl apply -f ./blue-controller.json (create replication controller for blue)
    * kubectl apply -f ./green-controller.json (create replication controller for green)
    * kubectl apply -f ./blue-green-service.json (create the service)
    * kubectl get svc

    Update the service to redirect to green by changing the selector to  app=green

    * kubectl apply -f ./blue-green-service.json (after making the above changes)
    * kubectl get svc (now the color of page should have changed)