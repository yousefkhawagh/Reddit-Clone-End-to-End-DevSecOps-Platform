terraform {
  backend "s3" {
    bucket         = "reddit-project-eks"
    key            = "End-to-End-Kubernetes-DevSecOps-Project/EKS-Server-TF/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-eks"
    encrypt        = true
  }
}
