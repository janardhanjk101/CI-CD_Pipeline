pipeline {
    agent none

    stages {
        stage('Clone Repository') {
            agent { label 'master' }
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
            agent { label 'master' }
            steps {
                sh 'docker build -t mynodeapp .'
            }
        }

        stage('Push Docker Image to Docker Hub') {
            agent { label 'master' }
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
            agent { label 'master' }
            steps {
                ansiblePlaybook playbook: 'deploy.yml'
            }
        }
    }
}
