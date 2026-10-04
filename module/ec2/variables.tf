variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "public_subnet_1_id" {
  type = string
}



variable "private_subnet_1_id" {
  type = string
}



variable "database_subnet_1_id" {
  type = string
}



variable "frontend_sg_id" {
  type = string
}

variable "backend_sg_id" {
  type = string
}

variable "database_sg_id" {
  type = string
}

variable "backend_iam_instance_profile" {

  description = "IAM instance profile for backend EC2 SSM access"

  type = string

}