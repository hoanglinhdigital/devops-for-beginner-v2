output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "alb_arn" {
  value = aws_lb.alb.arn
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.cluster.name
}
