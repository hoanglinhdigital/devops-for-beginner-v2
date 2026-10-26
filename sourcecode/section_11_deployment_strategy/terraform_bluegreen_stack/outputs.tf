output "alb_name" {
  value = module.load_balancer.alb_name
}

output "alb_dns_name" {
  value = module.load_balancer.alb_dns_name
}

output "production_url" {
  value = "http://${module.load_balancer.alb_dns_name}"
}

output "test_url" {
  value = "http://${module.load_balancer.alb_dns_name}:81"
}

output "ecs_cluster_names" {
  value = module.ecs.cluster_names
}

output "ecs_service_name" {
  value = module.ecs.service_name
}

output "task_definition_family" {
  value = module.ecs.task_definition_family
}

output "container_name" {
  value = module.ecs.container_name
}

output "target_group_names" {
  value = module.load_balancer.target_group_names
}
