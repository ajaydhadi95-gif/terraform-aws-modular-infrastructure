output "frontend_sg_id" {
  description = "Frontend Security Group ID"
  value       = aws_security_group.frontend.id
}

output "backend_sg_id" {
  description = "Backend Security Group ID"
  value       = aws_security_group.backend.id
}

output "database_sg_id" {
  description = "Database/RDS Security Group ID"
  value       = aws_security_group.rds.id
}