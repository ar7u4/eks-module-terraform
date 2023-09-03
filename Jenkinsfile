@Library('my-shared-lib') _

pipeline{

    agent any

    parameters{

        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
        string(name: 'aws_account_id', description: " AWS Account ID", defaultValue: '295134731113')
        string(name: 'Region', description: "Region of ECR", defaultValue: 'us-east-1')
        string(name: 'ECR_REPO_NAME', description: "name of the ECR", defaultValue: 'ar7u4')
        string(name: 'cluster', description: "name of the EKS Cluster", defaultValue: 'demo-cluster1')
    }
    environment{

        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_KEY_ID')
        AWS_DEFAULT_REGION = 'us-east-1'
        ECR_REPO_URI = '295134731113.dkr.ecr.us-east-1.amazonaws.com/ar7u4'
    }

    stages{
         
        stage('Git Checkout'){
                    when { expression {  params.action == 'create' } }
            steps{
            gitCheckout(
                branch: "main",
                url: "https://github.com/ar7u4/eks-module-terraform.git"
            )
            }
        }
        //  stage('Unit Test maven'){
         
        //  when { expression {  params.action == 'create' } }

        //     steps{
        //        script{
                   
        //            mvnTest()
        //        }
        //     }
        // }
        //  stage('Integration Test maven'){
        //  when { expression {  params.action == 'create' } }
        //     steps{
        //        script{
                   
        //            mvnIntegrationTest()
        //        }
        //     }
        // }
        // stage('Static code analysis: Sonarqube'){
        //  when { expression {  params.action == 'create' } }
        //     steps{
        //        script{
                   
        //            def SonarQubecredentialsId = 'sonar-token-new'
        //            statiCodeAnalysis(SonarQubecredentialsId)
        //        }
        //     }
        // }
        // stage('Quality Gate Status Check : Sonarqube'){
        //  when { expression {  params.action == 'create' } }
        //     steps{
        //        script{
                   
        //            def SonarQubecredentialsId = 'sonarqube-api'
        //            QualityGateStatus(SonarQubecredentialsId)
        //        }
        //     }
        // }
        // stage('Maven Build : maven'){
        //  when { expression {  params.action == 'create' } }
        //     steps{
        //        script{
                   
        //            mvnBuild()
        //        }
        //     }
        // }
        // stage('Docker Image Build : ECR'){
        //  when { expression {  params.action == 'create' } }
        //     steps{
        //        script{
                   
        //            dockerBuild("${params.aws_account_id}","${params.Region}","${params.ECR_REPO_NAME}")
        //        }
        //     }
        // }
        // stage('Push to ECR') {
        //     steps {
        //         script {
        //                 // Get AWS ECR login token
        //                 def ecrLogin = sh(script: "aws ecr get-login-password --region ${params.Region}", returnStdout: true).trim()
        //                 sh "echo ${ecrLogin} | docker login --username AWS --password-stdin ${ECR_REPO_URI}"
        //                 dockerImagePush("${params.aws_account_id}","${params.Region}","${params.ECR_REPO_NAME}")
        //         }
        //     }
        // }
        // stage('Docker Image Cleanup : ECR '){
        //  when { expression {  params.action == 'create' } }
        //     steps{
        //        script{
                   
        //            dockerImageCleanup("${params.aws_account_id}","${params.Region}","${params.ECR_REPO_NAME}")
        //        }
        //     }
        // }
        stage('Connect to AWS '){
            when { expression {  params.action == 'create' } }
            steps{

                script{

                    sh """
                    aws configure set aws_access_key_id "$ACCESS_KEY"
                    aws configure set aws_secret_access_key "$SECRET_KEY"
                    aws configure set region "${params.Region}"
                    """
                }
            }
        }
        stage('Create EKS Cluster : Terraform'){
            when { expression {  params.action == 'create' } }
            steps{
                script{

                      sh """
                          
                          terraform init                          
                          terraform plan --var-file=./config/terraform.tfvars
                          terraform apply --var-file=./config/terraform.tfvars --auto-approve 
                         
                      """
                }
            }
        }
        stage('Connect to EKS '){
            when { expression {  params.action == 'create' } }
            steps{

                script{

                    sh """
                    aws eks --region ${params.Region} update-kubeconfig --name ${params.cluster}
                    """
                }
            }
        } 
        // stage('Deployment on EKS Cluster'){
        //     when { expression {  params.action == 'create' } }
        //     steps{
        //         script{
                  
        //           def apply = false

        //           try{
        //             input message: 'please confirm to deploy on eks', ok: 'Ready to apply the config ?'
        //             apply = true
        //           }catch(err){
        //             apply= false
        //             currentBuild.result  = 'UNSTABLE'
        //           }
        //           if(apply){

        //             sh """
        //               kubectl apply -f .
        //             """
        //           }
        //         }
        //     }
        // } 

    }
}     