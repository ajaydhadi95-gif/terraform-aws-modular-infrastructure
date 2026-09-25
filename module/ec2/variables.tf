variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_name" {
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

variable "key_name" {
  type    = string
  default = "Dhadi"
}

variable "subnet_id" {
  type = string
}

variable "private_subnet_1_id" {
  type = string
}

variable "private_subnet_2_id" {
  type = string
}