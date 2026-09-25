# ========================================
# VPC MODULE
# ========================================

module "vpc" {
  source = "./module/vpc"

  vpc_cidr = "10.0.0.0/16"
  vpc_name = "terraform-vpc"
}


# ========================================
# SECURITY GROUP MODULE
# ========================================

module "security_group" {
  source = "./module/security_group"

  vpc_id = module.vpc.vpc_id
}


# ========================================
# EC2 MODULE
# ========================================

module "ec2" {
  source = "./module/ec2"

  ami_id        = var.ami_id
  instance_type = var.instance_type
  instance_name = var.instance_name
  key_name      = "Dhadi"

  # Security Groups
  frontend_sg_id = module.security_group.frontend_sg_id
  backend_sg_id  = module.security_group.backend_sg_id
  database_sg_id = module.security_group.database_sg_id

  # Subnets
  subnet_id           = module.vpc.subnet_id
  private_subnet_1_id = module.vpc.private_subnet_1_id
  private_subnet_2_id = module.vpc.private_subnet_2_id
}