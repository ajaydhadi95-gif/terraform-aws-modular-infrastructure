resource "aws_security_group" "ec2_sg" {
  name        = var.security_group_name
  description = var.security_group_description

  ingress {
    description = "SSH"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_name
  }
}