module "vpc" {
  source = "./modules/vpc"

  project_name         = var.project_name
  cluster_name         = var.cluster_name
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

module "iam" {
  source = "./modules/iam"

  project_name      = var.project_name
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.cluster_oidc_issuer_url
  tags              = var.tags
}

module "eks" {
  source = "./modules/eks"

  cluster_name     = var.cluster_name
  cluster_version  = var.cluster_version
  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn
  subnet_ids       = module.vpc.private_subnet_ids # Best practice: nodes in private subnets

  desired_size   = var.desired_size
  max_size       = var.max_size
  min_size       = var.min_size
  instance_types = var.instance_types
  tags           = var.tags
}

module "load_balancer_controller" {
  source = "./modules/load_balancer_controller"

  project_name           = var.project_name
  eks_cluster_name       = var.cluster_name
  vpc_id                 = module.vpc.vpc_id
  alb_ingress_role_arn   = module.iam.alb_ingress_role_arn
  tags                   = var.tags
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "eks_cluster_certificate_authority_data" {
  description = "The certificate authority data for the EKS cluster"
  value       = module.eks.cluster_certificate_authority_data
}

output "alb_controller_namespace" {
  description = "The namespace where the ALB controller is deployed"
  value       = module.load_balancer_controller.alb_controller_namespace
}

output "alb_controller_service_account" {
  description = "The service account used by the ALB controller"
  value       = module.load_balancer_controller.alb_controller_service_account
}

output "alb_controller_helm_release" {
  description = "The Helm release name for the ALB controller"
  value       = module.load_balancer_controller.alb_controller_helm_release
}
