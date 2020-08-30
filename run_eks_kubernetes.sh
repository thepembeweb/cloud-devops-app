aws eks --region us-east-1 update-kubeconfig --name cloud-devops-app-cluster
kubectl apply -f ./deployment/eks-deployment.yml
kubectl set image deployment/cloud-devops-app-deploy cloud-devops-app-pod=pembeweb/cloud-devops-app:latest --record
kubectl get deployments
kubectl get pods
kubectl get nodes
kubectl get svc
kubectl rollout status deployment.v1.apps/cloud-devops-app-deploy