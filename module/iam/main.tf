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
    Purpose   = "Jenkins EC2 SSM and EKS Access"
  }
}

# Allow Jenkins EC2 to use AWS Systems Manager

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Allow Jenkins EC2 to describe the EKS cluster

resource "aws_iam_role_policy" "jenkins_eks_describe" {
  name = "jenkins-eks-describe-cluster"
  role = aws_iam_role.ssm_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:DescribeCluster"
        ]
        Resource = "arn:aws:eks:ap-south-1:174376948569:cluster/devops-eks"
      }
    ]
  })
}

# Instance profile attached to Jenkins EC2

resource "aws_iam_instance_profile" "ssm_profile" {
  name = var.ssm_instance_profile_name
  role = aws_iam_role.ssm_role.name

  tags = {
    Name      = var.ssm_instance_profile_name
    ManagedBy = "Terraform"
  }
}
