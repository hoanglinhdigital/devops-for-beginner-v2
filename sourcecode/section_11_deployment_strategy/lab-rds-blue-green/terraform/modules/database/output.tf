output "rds_endpoint" {
  description = "Endpoint day du (address:port)"
  value       = aws_db_instance.this.endpoint
  sensitive   = true
}

output "rds_address" {
  description = "Hostname cua RDS instance"
  value       = aws_db_instance.this.address
  sensitive   = true
}

output "rds_port" {
  value = aws_db_instance.this.port
}

output "db_name" {
  value = aws_db_instance.this.db_name
}

output "rds_identifier" {
  description = "DB identifier - giu nguyen sau khi switchover (Green duoc doi ten thanh ten nay)"
  value       = aws_db_instance.this.identifier
}

output "parameter_group_blue_name" {
  value = aws_db_parameter_group.mysql80.name
}

output "parameter_group_green_name" {
  description = "Parameter group chon cho GREEN khi tao Blue/Green Deployment"
  value       = aws_db_parameter_group.mysql84.name
}

output "db_secret_arn" {
  description = "ARN secret chua thong tin ket noi DB (key: username, password, host, port, dbname, DATABASE_URL)"
  value       = aws_secretsmanager_secret.db.arn
}

output "db_secret_name" {
  value = aws_secretsmanager_secret.db.name
}
