
module "security_group" {
  source = "./module/security_group"
}

module "ec2" {
  source = "./module/ec2"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  instance_name     = var.instance_name
  security_group_id = module.security_group.security_group_id
  key_name          = "Dhadi"
}