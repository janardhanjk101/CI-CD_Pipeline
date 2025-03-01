groovy
CopyEdit
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
                DOCKER_USER = credentials('dockerhub-credentials') // Set in Jenkins credentials
            }
            steps {
                sh 'docker login -u $DOCKER_USER -p $DOCKER_PASSWORD'
                sh 'docker tag mynodeapp YOUR_DOCKERHUB_USERNAME/mynodeapp:latest'
                sh 'docker push YOUR_DOCKERHUB_USERNAME/mynodeapp:latest'
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

