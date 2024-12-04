pipeline {
        agent any
        environment {
                PROJECT_ID = 'opensource2024'
                CLUSTER_NAME = 'k8s'
                LOCATION = 'asia-northeast1-a'
                CREDENTIALS_ID = 'ed142ab5-14ad-4be2-a351-0ebed38f683f'
        }
        stages {
                stage("Checkout code") {
                        steps {
                                checkout scm
                        }
                }
                stage("Build image") {
                        steps {
                                script {
                                        myapp = docker.build("maengkim/j00:${env.BUILD_ID}")
                                }
                        }
                }
                stage("Push Image") {
                        steps {
                                script {
                                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                                                myapp.push("latest")
                                                myapp.push("${env.BUILD_ID}")
                                        }
                                }
                        }
                }
                stage('Deploy to GKE') {
                        when {
                                branch 'main'
                        }
                        steps {
                                sh "sed -i 's/j00:latest/j00:${env.BUILD_ID}/g' Deployment.yaml"
                                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'Deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
                        }
                }
        }
}
