terraform {
  backend "s3" {
    bucket         = "reddit-project-jenkins"
    key            = "End-to-End-Kubernetes-DevSecOps-Project/Jenkins-Server-TF/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-jenkins"
    encrypt        = true
  }
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}
