output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.my_instance.id
}

output "public_ip" {
  description = "EC2 public IP"
  value       = aws_instance.my_instance.public_ip
}