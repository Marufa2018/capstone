eksctl create cluster --name pod --region us-east-2 --version 1.14 --nodegroup-name workers --node-type t2.micro --nodes 3 --nodes-min 1 --nodes-max 4 --node-ami auto