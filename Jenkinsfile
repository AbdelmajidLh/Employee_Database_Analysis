pipeline {
    agent any

    environment {
        SERVER_HOST = credentials('server-host')  // IP du serveur Ubuntu
        SERVER_USER = credentials('server-user')  // Utilisateur SSH
        SERVER_SSH_KEY = credentials('server-ssh-key')  // Clé SSH pour Jenkins
    }

    stages {
        stage('🔄 Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/AbdelmajidLh/Employee_Database_Analysis.git'
            }
        }

        stage('✅ Run Tests') {
            steps {
                bat 'Rscript tests/tests.R'
            }
        }

        stage('🐳 Build Docker Image') {
            steps {
                bat 'docker build -t r_project .'
                bat 'docker save -o r_project.tar r_project'
            }
        }

        stage('📤 Transfer Docker Image to Server') {
            steps {
                sshagent(['server-ssh-key']) {
                    bat """
                    scp r_project.tar $SERVER_USER@$SERVER_HOST:/home/$SERVER_USER/
                    """
                }
            }
        }

        stage('🚀 Deploy to Ubuntu Server') {
            steps {
                sshagent(['server-ssh-key']) {
                    sh """
                    ssh $SERVER_USER@$SERVER_HOST <<EOF
                    docker load -i /home/$SERVER_USER/r_project.tar
                    docker stop r_project || true
                    docker rm r_project || true
                    docker run -d --name r_project --restart=always -p 8000:8000 r_project
                    EOF
                    """
                }
            }
        }
    }
}
