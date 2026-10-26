output "alb_name" {
  value = aws_lb.alb.name
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

# Map môi trường -> ARN, ví dụ { blue = "arn:...", green = "arn:..." }
output "target_group_arns" {
  value = { for env, tg in aws_lb_target_group.env : env => tg.arn }
}

output "target_group_names" {
  value = { for env, tg in aws_lb_target_group.env : env => tg.name }
}
