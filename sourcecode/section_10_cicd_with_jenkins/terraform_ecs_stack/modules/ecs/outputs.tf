output "cluster_name" {
  value = aws_ecs_cluster.cluster.name
}

output "service_name" {
  value = aws_ecs_service.nodejs.name
}

output "task_definition_family" {
  value = aws_ecs_task_definition.nodejs.family
}

output "container_name" {
  value = "nodejs-container"
}
