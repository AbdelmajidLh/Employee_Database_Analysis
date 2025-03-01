pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "r_project"
        SERVER_HOST = credentials('server-host')    // Adresse IP Ubuntu
        SERVER_USER = credentials('server-user')    // Utilisateur Ubuntu
        SERVER_SSH_KEY = credentials('server-ssh-key') // Clé privée SSH
    }

    stages {
        stage('🔄 Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/AbdelmajidLh/Employee_Database_Analysis.git'
            }
        }
        stage('✅ Run Tests') {
            steps {
                bat 'Rscript -e "source(\'renv/activate.R\')"'
                bat 'Rscript tests/tests.R'
    }
}

        stage('🐳 Build Docker Image') {
            steps {
                bat 'docker build -t r_project .'
            }
        }

        stage('📤 Transfer Docker Image to Server') {
            steps {
                sshagent(['server-ssh-key']) {
                    bat """
                    docker save -o r_project.tar r_project
                    scp r_project.tar $SERVER_USER@$SERVER_HOST:/home/$SERVER_USER/r_project.tar
                    ssh $SERVER_USER@$SERVER_HOST 'docker load -i /home/$SERVER_USER/r_project.tar'
                    """
                }
            }
        }

        stage('🚀 Deploy to Ubuntu Server') {
            steps {
                sshagent(['server-ssh-key']) {
                    sh """
                    ssh $SERVER_USER@$SERVER_HOST <<EOF
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
