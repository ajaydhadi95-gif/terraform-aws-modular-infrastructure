output "instance_id" {
  value = module.ec2.instance_id
}

output "public_ip" {
  value = module.ec2.public_ip
}

output "frontend_sg_id" {
  value = module.security_group.frontend_sg_id
}

output "backend_sg_id" {
  value = module.security_group.backend_sg_id
}

output "database_sg_id" {
  value = module.security_group.database_sg_id
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr
}