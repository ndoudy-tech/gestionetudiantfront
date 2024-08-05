def TAG_SELECTOR = "1"

pipeline {
    agent any

    environment {
        NAME = 'cdc_client_front'
        imageName = 'brims15/frontgestionetudiant'
        //registryCredentials = "admin"
        // registry = "192.168.1.38:8081/"
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

      stage('Trigger ManifestUpdate') {
        steps {
          build job: 'updateManifestFiles', parameters: [string(name: 'DOCKERTAG', value: TAG_SELECTOR)]
        }

      }


    }

    post {

       changed {
            emailext attachLog: true, body: '$DEFAULT_CONTENT', subject: '$DEFAULT_SUBJECT',  to: 'cheikh.sall@afrilins.net'
       }
        failure {
            emailext attachLog: true, body: '$DEFAULT_CONTENT', subject: '$DEFAULT_SUBJECT',  to: 'cheikh.sall@afrilins.net'
        }

    }
}
