@Library('Jenkins-shared-library') _
pipeline {
    agent any 
    stages{
        stage('git checkout') {
            steps{
                script{
                    branch: "main",
                    url: "https://github.com/maroof16/ci-cd.git"
                }
            }
        }
    }
}