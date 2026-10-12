output "frontend_sg_id" {
  description = "Frontend Security Group ID"
  value       = aws_security_group.eks_node.id
}

output "backend_sg_id" {
  description = "Backend Security Group ID"
  value       = aws_security_group.eks_node.id
}

output "eks_cluster_sg_id" {
  description = "EKS Cluster Security Group ID"
  value       = aws_security_group.eks_cluster.id
}

output "eks_node_sg_id" {
  description = "EKS Node Security Group ID"
  value       = aws_security_group.eks_node.id
}

output "database_sg_id" {
  description = "Database/RDS Security Group ID"
  value       = aws_security_group.rds.id
}

output "jenkins_security_group_id" {
  description = "Jenkins EC2 Security Group ID"
  value       = aws_security_group.jenkins.id
}