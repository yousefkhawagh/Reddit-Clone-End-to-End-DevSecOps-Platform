aws_region = "us-east-1"
project_name = "reddit-clone"
cluster_name = "reddit-eks-cluster"
cluster_version = "1.31"
vpc_cidr = "10.0.0.0/16"
public_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets_cidr = ["10.0.10.0/24", "10.0.11.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]
desired_size = 2
max_size = 3
min_size = 1
instance_types = ["t3.medium"]
tags = {
  Environment = "production"
  Project     = "reddit-clone"
  ManagedBy   = "terraform"
}
