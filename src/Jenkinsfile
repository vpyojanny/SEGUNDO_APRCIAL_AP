pipeline {
    agent any
    stages {
        stage('ClonRepo') {
            steps {
                git branch: 'main', url: 'https://github.com/vpyojanny/SEGUNDO_PARCIAL_AP.git'
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}
