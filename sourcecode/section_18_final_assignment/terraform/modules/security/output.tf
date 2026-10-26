output "alb_security_group_id" {
  value = aws_security_group.alb.id
}

output "frontend_security_group_id" {
  value = aws_security_group.frontend.id
}

output "backend_security_group_id" {
  value = aws_security_group.backend.id
}

output "mongodb_security_group_id" {
  value = aws_security_group.mongodb.id
}

output "bastion_security_group_id" {
  value = aws_security_group.bastion.id
}
