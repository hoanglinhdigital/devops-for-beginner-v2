output "instance_id" {
  description = "ID của EC2 instance"
  value       = aws_instance.demo_instance.id
}

output "instance_public_ip" {
  description = "Elastic IP gắn vào EC2"
  value       = aws_eip.demo_eip.public_ip
}

output "instance_private_ip" {
  description = "Private IP của EC2"
  value       = aws_instance.demo_instance.private_ip
}

output "security_group_id" {
  description = "ID của Security Group"
  value       = aws_security_group.demo_sg.id
}

output "ssh_command" {
  description = "Lệnh SSH vào EC2"
  value       = "ssh -i ../keypair/udemy-key ec2-user@${aws_eip.demo_eip.public_ip}"
}
