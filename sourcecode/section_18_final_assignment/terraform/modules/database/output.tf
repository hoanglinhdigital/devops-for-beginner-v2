output "mongodb_private_ip" {
  value = aws_instance.mongodb.private_ip
}

output "mongodb_instance_id" {
  value = aws_instance.mongodb.id
}
