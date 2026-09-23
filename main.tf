module "vpc" {
  source = "./module/vpc"

  vpc_cidr = "10.0.0.0/16"
  vpc_name = "terraform-vpc"
}

module "security_group" {
  source = "./module/security_group"

  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./module/ec2"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  instance_name     = var.instance_name
  security_group_id = module.security_group.security_group_id
  key_name          = "Dhadi"
  subnet_id         = module.vpc.subnet_id
}