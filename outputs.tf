output "instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2.instance_id
}

output "public_ip" {
  description = "EC2 public IP"
  value       = module.ec2.public_ip
}

output "security_group_id" {
  description = "Security Group ID"
  value       = module.security_group.security_group_id
}