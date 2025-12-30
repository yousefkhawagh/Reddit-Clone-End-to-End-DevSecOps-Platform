terraform {
  backend "s3" {
    bucket         = "reddit-project-eks"
    key            = "End-to-End-Kubernetes-DevSecOps-Project/EKS-Server-TF/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-eks"
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
