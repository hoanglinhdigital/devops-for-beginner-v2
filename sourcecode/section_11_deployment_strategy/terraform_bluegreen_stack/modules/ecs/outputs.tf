output "cluster_names" {
  value = { for env, cluster in aws_ecs_cluster.env : env => cluster.name }
}

output "service_name" {
  value = "nodejs-service"
}

output "task_definition_family" {
  value = aws_ecs_task_definition.nodejs.family
}

output "container_name" {
  value = "nodejs-container"
}
