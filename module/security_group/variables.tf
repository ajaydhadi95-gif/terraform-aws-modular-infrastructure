variable "security_group_name" {
  type    = string
  default = "terraform-ec2-sg"
}

variable "security_group_description" {
  type    = string
  default = "Allow SSH access"
}

variable "ssh_port" {
  type    = number
  default = 22
}

variable "ssh_cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
variable "vpc_id" {
  type = string
}