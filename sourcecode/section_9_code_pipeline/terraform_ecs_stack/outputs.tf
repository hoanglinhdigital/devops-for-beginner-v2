output "alb_dns_name" {
  value = module.load_balancer.alb_dns_name
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "ecs_service_name" {
  value = module.ecs.service_name
}

output "task_definition_family" {
  value = module.ecs.task_definition_family
}

output "task_execution_role_arn" {
  value = module.ecs.task_execution_role_arn
}

output "target_group_blue_name" {
  value = module.load_balancer.target_group_blue_name
}

output "target_group_green_name" {
  value = module.load_balancer.target_group_green_name
}
