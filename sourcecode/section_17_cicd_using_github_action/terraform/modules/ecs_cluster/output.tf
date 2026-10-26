output "cluster_names" {
  value = {
    for k, v in aws_ecs_cluster.env : k => v.name
  }
  description = "Tên của 2 ECS Cluster (blue/green)"
}
