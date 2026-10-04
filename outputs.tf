output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr
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

output "frontend_1_id" {
  value = module.ec2.frontend_1_id
}

output "backend_1_id" {
  value = module.ec2.backend_1_id
}
output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

