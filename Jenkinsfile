pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Install Dependencies') {
      steps {
        sh 'pip install -r requirements-dev.txt'
      }
    }
    stage('Lint & Test') {
      steps {
        sh 'ruff check .'
        sh 'pytest'
      }
    }
    stage('Build Docker Image') {
      steps {
        sh 'docker build -t hr-triage:latest .'
      }
    }
  }
}