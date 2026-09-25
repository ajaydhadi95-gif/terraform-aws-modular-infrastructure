# ========================================
# Frontend EC2 - Public Subnet
# ========================================

resource "aws_instance" "my_instance" {

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.frontend_sg_id
  ]

  tags = {
    Name = var.instance_name
  }
}


# ========================================
# Backend EC2 - Private Subnet 1
# ========================================

resource "aws_instance" "private_ec2_1" {

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id = var.private_subnet_1_id

  vpc_security_group_ids = [
    var.backend_sg_id
  ]

  tags = {
    Name = "private-ec2-1-backend"
  }
}


# ========================================
# Database EC2 - Private Subnet 2
# ========================================

resource "aws_instance" "private_ec2_2" {

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id = var.private_subnet_2_id

  vpc_security_group_ids = [
    var.database_sg_id
  ]

  tags = {
    Name = "private-ec2-2-database"
  }
}