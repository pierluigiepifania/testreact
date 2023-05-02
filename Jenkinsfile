pipeline {

  environment {
    dockerimagename = "pierluigiep/test"
    dockerImage = ""

    tools {
      'org.jenkinsci.plugins.docker.commons.tools.DockerTool' 'docker'
     }
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
         docker.withTool('docker'){
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
		}
          }
        }
      }
    }

    stage('Deploying React.js container to Kubernetes') {
      steps {
        script {
          kubernetesDeploy(configs: "deployment.yaml", "service.yaml")
        }
      }
    }

  }

}