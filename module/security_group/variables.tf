variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

# =========================================================
# EKS CLUSTER SECURITY GROUP
# =========================================================

variable "eks_cluster_security_group_name" {
  description = "Security group name for EKS cluster"
  type        = string
  default     = "terraform-eks-cluster-sg"
}

variable "eks_cluster_security_group_description" {
  description = "Security group for EKS control plane"
  type        = string
  default     = "Security group for EKS control plane"
}


# =========================================================
# EKS NODE SECURITY GROUP
# =========================================================

variable "eks_node_security_group_name" {
  description = "Security group name for EKS worker nodes"
  type        = string
  default     = "terraform-eks-node-sg"
}

variable "eks_node_security_group_description" {
  description = "Security group for EKS worker nodes"
  type        = string
  default     = "Security group for EKS worker nodes"
}


# =========================================================
# APPLICATION PORTS
# =========================================================

variable "http_port" {
  description = "HTTP application port"
  type        = number
  default     = 80
}

variable "https_port" {
  description = "HTTPS application port"
  type        = number
  default     = 443
}

variable "backend_port" {
  description = "Backend application port"
  type        = number
  default     = 8080
}


# =========================================================
# RDS SECURITY GROUP
# =========================================================

variable "rds_security_group_name" {
  description = "Security group name for RDS"
  type        = string
  default     = "terraform-rds-sg"
}

variable "rds_security_group_description" {
  description = "Security group for RDS MySQL"
  type        = string
  default     = "Security group for RDS MySQL"
}

variable "sql_port" {
  description = "MySQL port"
  type        = number
  default     = 3306
}
# =========================================================
# JENKINS SECURITY GROUP
# =========================================================

variable "jenkins_security_group_name" {
  description = "Security group name for Jenkins EC2"
  type        = string
  default     = "terraform-jenkins-sg"
}

variable "jenkins_security_group_description" {
  description = "Security group description for Jenkins EC2"
  type        = string
  default     = "Security group for Jenkins CI/CD server"
}

variable "ssh_port" {
  description = "SSH port for Jenkins EC2"
  type        = number
  default     = 22
}

variable "jenkins_port" {
  description = "Jenkins web UI port"
  type        = number
  default     = 8080
}

variable "jenkins_allowed_cidr" {
  description = "Allowed IP for Jenkins SSH and web access"
  type        = string
  default     = "0.0.0.0/0"
}

