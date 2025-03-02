pipeline {
    agent any  // Runs on the available node (built-in Jenkins node)

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/janardhanjk101/CICKprojectusingvagrant.git'
            }
        }

        stage('Build and Test') {
            agent {
                docker { image 'node:16-alpine' }
            }
            steps {
                sh 'npm install'
                sh 'npm test'  // Run tests (optional)
            }
        }

        stage('Create Docker Image') {
            steps {
                sh 'docker build -t mynodeapp .'
            }
        }

        stage('Push Docker Image to Docker Hub') {
            environment {
                DOCKER_CREDENTIALS = credentials('dockerhub-credentials')  // Use saved Jenkins credentials
            }
            steps {
                sh 'echo "$DOCKER_CREDENTIALS_PSW" | docker login -u "$DOCKER_CREDENTIALS_USR" --password-stdin'
                sh 'docker tag mynodeapp $DOCKER_CREDENTIALS_USR/mynodeapp:latest'
                sh 'docker push $DOCKER_CREDENTIALS_USR/mynodeapp:latest'
            }
        }

        stage('Deploy to PC 3') {
            steps {
                ansiblePlaybook (
                inventory: 'hosts.ini',
                playbook: 'deploy.yml'
                )
            }
        }
    }
}
