output "alb_dns_name" {
  description = "DNS name của Application Load Balancer (truy cập frontend qua đây)"
  value       = module.application.alb_dns_name
}

output "frontend_repository_url" {
  description = "URI repository ECR của frontend"
  value       = module.storage.frontend_repository_url
}

output "backend_repository_url" {
  description = "URI repository ECR của backend"
  value       = module.storage.backend_repository_url
}

output "mongodb_private_ip" {
  description = "Private IP của máy chạy MongoDB (dùng để kiểm tra backend)"
  value       = module.database.mongodb_private_ip
}

output "ecs_cluster_name" {
  description = "Tên ECS cluster"
  value       = module.application.ecs_cluster_name
}
