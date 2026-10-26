output "instance_public_ip" {
  value = aws_eip.demo_eip.public_ip
}

output "instance_private_ip" {
  value = aws_instance.demo_instance.private_ip
}
