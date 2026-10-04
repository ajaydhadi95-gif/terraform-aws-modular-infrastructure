resource "aws_iam_role" "ssm_role" {
  name = var.ssm_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name      = var.ssm_role_name
    ManagedBy = "Terraform"
    Purpose   = "SSM Session Manager"
  }
}


resource "aws_iam_role_policy_attachment" "ssm" {
  role = aws_iam_role.ssm_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


resource "aws_iam_instance_profile" "ssm_profile" {
  name = var.ssm_instance_profile_name

  role = aws_iam_role.ssm_role.name

  tags = {
    Name      = var.ssm_instance_profile_name
    ManagedBy = "Terraform"
  }
}