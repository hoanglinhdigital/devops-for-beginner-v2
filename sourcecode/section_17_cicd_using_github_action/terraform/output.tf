output "alb_dns" {
  value       = module.load_balance.alb_dns
  description = "DNS của Application Load Balancer (truy cập production qua cổng 80, test qua cổng 81)"
}

output "alb_arn" {
  value       = module.load_balance.alb_arn
  description = "ARN của Application Load Balancer"
}

output "alb_name" {
  value       = module.load_balance.alb_name
  description = "Tên của Application Load Balancer"
}
