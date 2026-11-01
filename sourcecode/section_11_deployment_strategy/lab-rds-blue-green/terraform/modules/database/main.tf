# ---------------------------------------------------------------------------
# Master password - Terraform tu sinh, KHONG khai bao trong terraform.tfvars.
# special = false: password duoc ghep vao DATABASE_URL (mysql://user:pass@host),
# cac ky tu nhu @ / : ? # se lam hong URL.
# Luu y: gia tri van nam trong terraform.tfstate -> state phai duoc bao ve
# (khong commit, dung S3 backend co encryption o moi truong that).
# ---------------------------------------------------------------------------
resource "random_password" "db_master" {
  length  = 24
  special = false
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-${var.environment}-db-subnet-group-01"
  subnet_ids = var.data_subnet_ids

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-db-subnet-group-01"
  })
}

# ---------------------------------------------------------------------------
# Parameter Group cho RDS Blue/Green Deployment
# - mysql80: parameter group cua moi truong BLUE (MySQL 8.0 dang chay production)
# - mysql84: parameter group "dich" cua moi truong GREEN (MySQL 8.4). Hoc vien
#   chon parameter group nay khi tao Blue/Green Deployment tren AWS Console.
#   Bat slow query log tren GREEN de de dang phan biet BLUE/GREEN khi kiem tra
#   (SHOW VARIABLES LIKE 'slow_query_log').
# Sau khi switchover, sua var.active_parameter_group = "mysql84" de Terraform
# khop voi thuc te (xem bai lab - buoc dong bo lai Terraform state).
# ---------------------------------------------------------------------------
resource "aws_db_parameter_group" "mysql80" {
  name        = "${var.project_name}-${var.environment}-pg-mysql80-01"
  family      = "mysql8.0"
  description = "BLUE - MySQL 8.0"

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-pg-mysql80-01"
  })
}

resource "aws_db_parameter_group" "mysql84" {
  name        = "${var.project_name}-${var.environment}-pg-mysql84-01"
  family      = "mysql8.4"
  description = "GREEN - MySQL 8.4 (target cua RDS Blue/Green Deployment)"

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "long_query_time"
    value = "1"
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-pg-mysql84-01"
  })
}

locals {
  parameter_group_names = {
    mysql80 = aws_db_parameter_group.mysql80.name
    mysql84 = aws_db_parameter_group.mysql84.name
  }
}

resource "aws_db_instance" "this" {
  identifier     = "${var.project_name}-${var.environment}-rds-mysql-01"
  engine         = "mysql"
  engine_version = var.engine_version
  instance_class = var.db_instance_class

  allocated_storage = var.allocated_storage
  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = var.db_name
  username = var.db_username
  password = random_password.db_master.result

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.rds_sg_id]
  parameter_group_name   = local.parameter_group_names[var.active_parameter_group]

  # Trade-off tam thoi cho dev: cho phep public IP de seed data tu may ca nhan
  # qua Internet (xem enable_public_rds_access + allowed_ip_cidrs o module
  # security, va data_subnet_internet_access_enabled o module network).
  # prod BAT BUOC false.
  publicly_accessible = var.publicly_accessible

  # Trade-off cho moi trung dev: cho phep Single-AZ (multi_az=false) de tiet kiem chi phi.
  # prod BAT BUOC multi_az = true theo skill aws-architecture-design / terraform-aws-generator.
  multi_az = var.multi_az

  # RDS Blue/Green Deployment cho MySQL BAT BUOC bat automated backup
  # (backup_retention_period > 0) de bat binary log - Green dong bo du lieu tu
  # Blue qua binlog replication.
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.environment != "prd"
  deletion_protection     = var.environment == "prd"
  apply_immediately       = var.environment != "prd"

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-rds-mysql-01"
  })
}

# ---------------------------------------------------------------------------
# Secrets Manager - luu thong tin ket noi database.
# - ECS Task Definition doc key DATABASE_URL qua "secrets" (valueFrom), gia tri
#   khong xuat hien trong Task Definition / Console ECS.
# - Hoc vien doc username/password tu secret de ket noi MySQL Workbench.
# Sau khi switchover RDS Blue/Green, endpoint (host) KHONG doi nen secret van dung.
# ---------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "db" {
  name        = "${var.project_name}/${var.environment}/rds-mysql-01"
  description = "Thong tin ket noi RDS MySQL cho ${var.project_name}-${var.environment}"

  # dev/lab: 0 = xoa ngay khi terraform destroy, cho phep tao lai secret cung
  # ten ngay lap tuc. prod nen de 7-30 ngay de khoi phuc khi xoa nham.
  recovery_window_in_days = var.secret_recovery_window_in_days

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-secret-rds-01"
  })
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id

  secret_string = jsonencode({
    engine       = "mysql"
    host         = aws_db_instance.this.address
    port         = aws_db_instance.this.port
    dbname       = var.db_name
    username     = var.db_username
    password     = random_password.db_master.result
    DATABASE_URL = "mysql://${var.db_username}:${random_password.db_master.result}@${aws_db_instance.this.address}:${aws_db_instance.this.port}/${var.db_name}"
  })
}
