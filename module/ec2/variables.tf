
variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "public_subnet_1_id" {
  type = string
}

variable "jenkins_security_group_id" {
  description = "Jenkins EC2 Security Group ID"
  type        = string
}

variable "key_name" {
  type = string
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile attached to Jenkins EC2"
  type        = string
}


