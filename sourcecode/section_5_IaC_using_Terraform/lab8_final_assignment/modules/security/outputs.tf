output "bastion_sg_id" {
  description = "bastion sg id"
  value       = aws_security_group.bastion.id
}

output "alb_sg_id" {
  description = "alb sg id"
  value       = aws_security_group.alb.id
}

output "application_sg_id" {
  description = "web server sg id"
  value       = aws_security_group.application.id
}

output "mongodb_sg_id" {
  description = "mongodb sg id"
  value       = aws_security_group.mongodb.id
}
