
# Frontend Security Group


resource "aws_security_group" "frontend" {
  name        = var.frontend_security_group_name
  description = var.frontend_security_group_description
  vpc_id      = var.vpc_id

  # HTTP
  ingress {
    description = "Allow HTTP"
    from_port   = var.frontend_http_port
    to_port     = var.frontend_http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    description = "Allow HTTPS"
    from_port   = var.frontend_https_port
    to_port     = var.frontend_https_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH
  ingress {
    description = "Allow SSH"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr
  }

  # Outbound
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.frontend_security_group_name
  }
}



# Backend Security Group


resource "aws_security_group" "backend" {
  name        = var.backend_security_group_name
  description = var.backend_security_group_description
  vpc_id      = var.vpc_id

  # Backend receives traffic from Frontend SG
  ingress {
    description     = "Allow backend traffic from frontend"
    from_port       = var.backend_port
    to_port         = var.backend_port
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend.id]
  }


  # Outbound
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.backend_security_group_name
  }
}



# RDS Security Group


resource "aws_security_group" "rds" {
  name        = var.rds_security_group_name
  description = var.rds_security_group_description
  vpc_id      = var.vpc_id

  # MySQL only from Backend SG
  ingress {
    description     = "Allow MySQL from backend"
    from_port       = var.sql_port
    to_port         = var.sql_port
    protocol        = "tcp"
    security_groups = [aws_security_group.backend.id]
  }

  # Outbound
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.rds_security_group_name
  }
}