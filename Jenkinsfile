pipeline {

  environment {
    dockerimagename = "pierluigiep/test"
    dockerImage = ""
  }

  agent any

   environment {
        PATH = "/usr/local/bin/:${PATH}"
    }

  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/pierluigiepifania/testreact.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }

    stage('Pushing Image') {
      environment {
               registryCredential = 'cred-dockerhub'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
          }
        }
      }
    }

    stage('Deploying React.js container to Kubernetes') {
	steps {
        sh "kubectl apply -f deployment.yaml"
	  sh "kubectl apply -f service.yaml"
      }
    }
  }
}