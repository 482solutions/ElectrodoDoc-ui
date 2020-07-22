 pipeline {
  agent { label '1' } 
  
  tools { nodejs "nodejs" }

  options { 
    timestamps () 
    ansiColor('xterm') 
  }
  environment {
    DOCKER_REGISTRY = 'nexus.482.solutions'
    NEXUS_READER_NAME = credentials('woden_nexus_reader_name')
    NEXUS_READER_PASSWORD = credentials('woden_nexus_reader_password')
    }
  stages {
    stage("Run Tests") {
      steps {
        //slackSend channel: "#wg-rnd", color: "green", message: "STARTED ${JOB_NAME} BUILD_NUMBER ${VERSION}", tokenCredentialId: "Slack482"
        sh 'npm i'
        sh 'npm run fix:js'
        sh 'npm run lint:js'
       //    sh 'echo "*** run fabric ***"'
        sh 'sudo rm -R -f woden-network && git clone https://github.com/482solutions/woden-network.git && cd woden-network && sudo -S ./deploy.sh'
      //     sh 'echo "*** run server ***"'
        sh 'docker login -u $NEXUS_READER_NAME -p $NEXUS_READER_PASSWORD $DOCKER_REGISTRY &&  git clone https://github.com/482solutions/woden-server-js.git && cd woden-server-js && docker-compose -f docker-compose-nexus.yaml up -d'
       //    sh 'echo "*** run UI ***"'
        sh 'npm run start -d & sleep 40'
      //     sh 'echo "*** Cypress authorization tests ***"'
        sh 'npm run cy:run:auth'
      //     sh 'echo "*** Cypress navigations tests ***"'
        sh 'npm run cy:run:nav'
       //    sh 'echo "*** Cypress CRU tests ***"'
        sh 'npm run cy:run:cru'
      //     sh 'echo "*** Cypress permissions tests ***"'
        sh 'npm run coverage'
         }
      }
    }
  post { 
    always { 
      sh "docker rm -v -f fabric_orderer fabric_peer fabric_ca fabric_ca_db backend ipfs redis postgres || true"
      sh 'sudo rm -R -f woden-network'
      cleanWs() 
    }
   /* success {
           slackSend channel: "#wg-rnd", color: "green", message: "SUCCESS ${JOB_NAME} BUILD_NUMBER ${VERSION}", tokenCredentialId: "Slack482"
    }
    failure {
            slackSend channel: "#wg-rnd", color: "red", message: "FAILURE ${JOB_NAME} BUILD_NUMBER ${VERSION}", tokenCredentialId: "Slack482"
    } */
  } 
}
