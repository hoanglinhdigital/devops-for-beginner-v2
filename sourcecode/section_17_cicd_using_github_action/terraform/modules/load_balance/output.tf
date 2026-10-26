output "target_group_blue_arn" {
  value = aws_lb_target_group.env["blue"].arn
}

output "target_group_green_arn" {
  value = aws_lb_target_group.env["green"].arn
}

output "alb_arn" {
  value = aws_lb.alb.arn
}

output "alb_name" {
  value = aws_lb.alb.name
}

output "alb_dns" {
  value = aws_lb.alb.dns_name
}
