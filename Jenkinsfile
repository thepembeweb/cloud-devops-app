pipeline {
  agent any
   stages {
    stage('Checkout SCM') {
        steps {
            script {
                echo 'Checkout Git repository'
                checkout scm
            }
        }
    }
    stage('React') {
      steps {
        dir('sample-app') {
            sh 'yarn cache clean'
            sh 'yarn install'
            sh 'yarn lint'
            sh 'yarn test'
            sh 'yarn build'
        }
      }
    }
    stage('Docker') {
      steps {
          sh 'docker build . --tag=$DOCKER_TAG'
          sh 'docker login -u $DOCKER_USER -p $DOCKER_PASSWORD'
          sh 'docker image push $DOCKER_TAG'
      }
    }
    stage('Kubernetes') {
      steps{
        withAWS(credentials: 'aws-udacity-devops', region: 'us-east-1'){
		      sh 'aws eks --region us-east-1 update-kubeconfig --name cloud-devops-app-cluster'
          sh 'kubectl apply -f ./deployment/eks-deployment.yml'
          sh 'kubectl set image deployment/cloud-devops-app-deploy cloud-devops-app-pod=pabloalbaladejo/cloud-devops-app:latest --record'
          sh 'kubectl get deployments'
          sh 'kubectl get pods'
          sh 'kubectl get nodes'
          sh 'kubectl get svc'
          sh 'kubectl rollout status deployment.v1.apps/cloud-devops-app-deploy'
		    }
	    }
    }
   }
}