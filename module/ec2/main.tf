resource "aws_instance" "frontend_ec2_1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_1_id
  vpc_security_group_ids = [var.frontend_sg_id]
  key_name               = var.key_name

  tags = {
    Name = "frontend-ec2-1"
    Tier = "Frontend"
    AZ   = "ap-south-1a"
  }
}


resource "aws_instance" "backend_ec2_1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_1_id
  vpc_security_group_ids = [var.backend_sg_id]
  key_name               = var.key_name

  iam_instance_profile = var.backend_iam_instance_profile

  tags = {
    Name = "backend-ec2-1"
    Tier = "Backend"
    AZ   = "ap-south-1a"
  }
}