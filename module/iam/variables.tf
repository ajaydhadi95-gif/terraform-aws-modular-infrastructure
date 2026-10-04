variable "ssm_role_name" {
  description = "IAM role used by EC2 for AWS Systems Manager"
  type        = string
  default     = "terraform-ssm-role"
}


variable "ssm_instance_profile_name" {
  description = "IAM instance profile used by backend EC2"
  type        = string
  default     = "terraform-ssm-instance-profile"
}