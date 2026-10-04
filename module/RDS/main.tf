resource "aws_db_subnet_group" "mysql" {
  name = "terraform-rds-subnet-group"

  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "terraform-rds-subnet-group"
  }
}

resource "aws_db_instance" "mysql" {
  identifier = "devops-mysql"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "bookingdb"
  username = var.db_username
  password = var.db_password

  port = 3306

  db_subnet_group_name = aws_db_subnet_group.mysql.name

  vpc_security_group_ids = [
    var.rds_security_group_id
  ]

  publicly_accessible = false
  storage_encrypted   = true

  backup_retention_period = 7

  multi_az = false

  skip_final_snapshot = true
  deletion_protection = false

  tags = {
    Name = "devops-mysql"
    Tier = "Database"
  }
}