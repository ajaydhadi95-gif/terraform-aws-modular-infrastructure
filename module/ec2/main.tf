resource "aws_instance" "deployment_jenkins_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_1_id
  vpc_security_group_ids = [var.jenkins_security_group_id]
  key_name               = var.key_name
  iam_instance_profile   = var.iam_instance_profile_name

  tags = {
    Name = "deployment-Jenkins-ec2"
    Tier = "Deployment"
    AZ   = "ap-south-1a"
  }
}