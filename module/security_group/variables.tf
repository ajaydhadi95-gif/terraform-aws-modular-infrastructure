variable "vpc_id" {
  type = string
}

# -------------------------
# Frontend Security Group
# -------------------------

variable "frontend_security_group_name" {
  type    = string
  default = "terraform-frontend-sg"
}

variable "frontend_security_group_description" {
  type    = string
  default = "Security group for frontend EC2"
}

variable "frontend_http_port" {
  type    = number
  default = 80
}

variable "frontend_https_port" {
  type    = number
  default = 443
}

variable "ssh_port" {
  type    = number
  default = 22
}

variable "ssh_cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}


# -------------------------
# Backend Security Group
# -------------------------

variable "backend_security_group_name" {
  type    = string
  default = "terraform-backend-sg"
}

variable "backend_security_group_description" {
  type    = string
  default = "Security group for backend EC2"
}

variable "backend_port" {
  type    = number
  default = 8080
}


# -------------------------
# RDS Security Group
# -------------------------

variable "rds_security_group_name" {
  type    = string
  default = "terraform-rds-sg"
}

variable "rds_security_group_description" {
  type    = string
  default = "Security group for RDS MySQL"
}

variable "sql_port" {
  type    = number
  default = 3306
}