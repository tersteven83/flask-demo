pipeline {
    agent {
        label 'jk-agent-debian'
    }
    stages {
        stage('Checkout') {
            steps {
                // withCredentials([string(credentialsId: 'gitlab-cred-str', variable: 'GITHUB_TOKEN')]) {
                    sh "echo passed"
                    git branch: 'main', url: 'https://github.com/tersteven83/flask-demo.git'
                // }
            }
        }
        stage('Setup environment') {
            steps {
                sh "python3 -m venv .venv"
                sh ". .venv/bin/activate"
                sh "pip install -e ."
            }
        }
        stage('Test') {
            steps {
                sh "pip install '.[test]'"
                sh "pytest"
            }
        }
        stage('Build and push Docker image') {
            environment {
                DOCKER_IMAGE = "steevi83/flask-demo:${BUILD_NUMBER}"
                DOCKERFILE_LOCATION = "Dockerfile"
                REGISTRY_CREDENTIALS = credentials('docker-cred')
            }
            steps {
                script {
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                    def dockerImage = docker.image("${env.DOCKER_IMAGE}")
                    docker.withRegistry('', env.REGIRSTRY_CREDENTIALS) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Run the image') {
            steps {
                script {
                    sh 'docker-compose -f docker-compose.yml up'
                }
            }
        }
    }
}