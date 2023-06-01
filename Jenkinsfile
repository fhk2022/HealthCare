pipeline {
  agent any

 tools  {
   maven 'M2_HOME'

        }
 stages {
   stage ('checkout') {
     steps  {
       echo  'Checkout the source code from github'
       git 'https://github.com/fhk2022/HealthCare.git'
            }
        }
   stage('Package the Application') {
     steps {
       echo "packaging the Application"
       sh 'mvn clean package'
          }
  }

  stage('Publish the Reports using HTML') {
    steps {
    publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/HealthCare-Project/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
          }
}
}
}

