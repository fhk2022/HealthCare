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
  stage('Docker Image Creation'){
    steps {
    sh 'docker build -t  faisalhkdocker/healthcare:latest  .'
          }            
}
 stage('Push Image to DockerHub'){
    steps {
       withCredentials([usernamePassword(credentialsId: 'docker-hub-cred', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
       sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
       sh 'docker push  faisalhkdocker/healthcare:latest'

                    }
           }
            }
 stage ('create infra  with Terraform, Ansible and then Deploy the application'){
   steps {
     dir('test-server'){
     sh 'chmod 400 Project2.pem'
     sh 'terraform init'
     sh 'terraform validate'
     sh 'terraform apply --auto-approve'
                }
            }
        }

}

}

