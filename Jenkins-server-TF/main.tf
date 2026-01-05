module "vpc" {
  source            = "./modules/vpc"
  vpc_name          = var.vpc_name
  igw_name          = var.igw_name
  subnet_name       = var.subnet_name
  rt_name           = var.rt_name
  sg_name           = var.sg_name
  availability_zone = var.availability_zone
}

module "iam" {
  source        = "./modules/iam"
  iam_role_name = var.iam_role_name
}

module "ec2" {
  source               = "./modules/ec2"
  instance_name        = var.instance_name
  instance_type        = var.instance_type
  key_name             = var.key_name
  subnet_id            = module.vpc.subnet_id
  security_group_id    = module.vpc.security_group_id
  iam_instance_profile = module.iam.instance_profile_name
  user_data_path       = "${path.module}/scripts/tools-install.sh"
}
