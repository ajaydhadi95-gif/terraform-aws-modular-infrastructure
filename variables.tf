variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "instance_name" {
  type    = string
  default = "my_terraform_instance"
}

variable "ami_id" {
  type    = string
  default = "ami-01a00762f46d584a1"
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "devops-vpc"
}

variable "key_name" {
  description = "AWS EC2 key pair name"
  type        = string
  default     = "Dhadi"
}
variable "db_username" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}