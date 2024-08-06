def TAG_SELECTOR = "1"

pipeline {
    agent any

    environment {
        NAME = 'cdc_client_front'
        imageName = 'ndoudy24/gestionetudiantfront'
        //registryCredentials = "admin"
        // registry = "192.168.1.28:8081/"
        dockerImage = ''
//
        dockerHubRegistry = "https://registry.hub.docker.com"
    }
    options {
      timeout(time: 120, unit: 'MINUTES')
    }

    stages {

       /* stage('INSTALL NPM') {
            steps {
                sh  "npm install --legacy-peer-deps"
            }
        }

        stage('BUILD NPM') {
            when { branch 'master' }
            steps {
                sh  "npm run build"

            }
        }

        */

         stage('Building image') {


          steps{
            echo ("TAG_SELECTOR====================>${TAG_SELECTOR}")
         script {
         dockerImage = docker.build imageName
         }
         }
         }

       stage('Dockerize: Pushing Image docker hub') {
         environment {
         registryCredential = 'DOCKER_CREDENTIALS'
         }
         steps{
           echo ("TAG_SELECTOR====================>${TAG_SELECTOR}")
         script {
         docker.withRegistry( dockerHubRegistry,registryCredential){
         dockerImage.push("${TAG_SELECTOR}")
         }
         }
         }
         }

    


    }

   
}
