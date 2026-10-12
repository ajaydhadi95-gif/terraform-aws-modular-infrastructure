output "jenkins_instance_id" {
  value = aws_instance.deployment_jenkins_ec2.id
}

output "jenkins_public_ip" {
  value = aws_instance.deployment_jenkins_ec2.public_ip
}

output "jenkins_private_ip" {
  value = aws_instance.deployment_jenkins_ec2.private_ip
}