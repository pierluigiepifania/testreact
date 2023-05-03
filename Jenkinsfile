pipeline {

  environment {
    dockerimagename = "pierluigiep/test"
    dockerImage = ""
  }

  agent any

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
        sh "$(which kubectl)" apply -f deployment.yaml
        sh "$(which kubectl)" apply -f service.yaml
      }
    }
  }
}