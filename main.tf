
module "vpc" {
  source   = "./module/vpc"
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

module "rds" {
  source = "./module/rds"

  db_subnet_ids = [
    module.vpc.database_subnet_1_id,
    module.vpc.database_subnet_2_id
  ]

  rds_security_group_id = module.security_group.database_sg_id
  db_username           = var.db_username
  db_password           = var.db_password
}

module "Deployment_jenkins_ec2" {
  source = "./module/ec2"

  ami_id                    = var.ami_id
  instance_type             = var.instance_type
  public_subnet_1_id        = module.vpc.public_subnet_1_id
  jenkins_security_group_id = module.security_group.jenkins_security_group_id
  key_name                  = var.key_name

  iam_instance_profile_name = module.iam.ssm_instance_profile_name
}

module "eks" {
  source = "./module/eks"

  cluster_name    = "devops-eks"
  cluster_version = "1.34"

  vpc_id = module.vpc.vpc_id

  private_subnet_ids = [
    module.vpc.private_subnet_1_id,
    module.vpc.private_subnet_2_id
  ]

  cluster_security_group_id = module.security_group.eks_cluster_sg_id
  node_security_group_id    = module.security_group.eks_node_sg_id

  node_instance_type = "t3.medium"
  desired_nodes      = 2
  min_nodes          = 2
  max_nodes          = 3
}

