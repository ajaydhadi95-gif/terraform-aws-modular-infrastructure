module "vpc" {

  source = "./module/vpc"

  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name

}


module "security_group" {

  source = "./module/security_group"

  vpc_id = module.vpc.vpc_id

}


module "iam" {

  source = "./module/iam"

}


module "ec2" {

  source = "./module/ec2"

  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  public_subnet_1_id = module.vpc.public_subnet_1_id

  private_subnet_1_id = module.vpc.private_subnet_1_id

  database_subnet_1_id = module.vpc.database_subnet_1_id

  frontend_sg_id = module.security_group.frontend_sg_id

  backend_sg_id = module.security_group.backend_sg_id

  database_sg_id = module.security_group.database_sg_id

  backend_iam_instance_profile = module.iam.ssm_instance_profile_name

}


module "rds" {

  source = "./module/rds"

  db_subnet_ids = [

    module.vpc.database_subnet_1_id,
    module.vpc.database_subnet_2_id

  ]

  rds_security_group_id = module.security_group.database_sg_id

  db_username = var.db_username
  db_password = var.db_password

}