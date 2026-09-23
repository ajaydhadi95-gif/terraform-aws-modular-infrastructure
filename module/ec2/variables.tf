variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "key_name" {
  type    = string
  default = "Dhadi"
}

variable "subnet_id" {
  type = string
}