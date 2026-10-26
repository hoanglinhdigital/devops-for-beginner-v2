output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "target_group_blue_arn" {
  value = aws_lb_target_group.blue.arn
}

output "target_group_blue_name" {
  value = aws_lb_target_group.blue.name
}

output "target_group_green_name" {
  value = aws_lb_target_group.green.name
}
