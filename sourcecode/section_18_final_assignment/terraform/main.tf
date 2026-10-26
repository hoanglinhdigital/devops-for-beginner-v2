terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
  # Để bài tập đơn giản, dùng local state.
  # Có thể nâng cấp sang S3 backend + DynamoDB lock (xem lại Section 5 – Lab 9).
}

provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

locals {
  project   = "final-assignment"
  account_id = data.aws_caller_identity.current.account_id
}

# ─── 1. Network: VPC 3 tầng (2 public + 2 private subnet), IGW + NAT Gateway ───
module "network" {
  source             = "./modules/network"
  region             = var.region
  availability_zones = var.availability_zones
  cidr_block         = var.cidr_block
  public_subnet_ips  = var.public_subnet_ips
  private_subnet_ips = var.private_subnet_ips
}

# ─── 2. Security: Security Groups (ALB, frontend, backend, MongoDB) ───
module "security" {
  source     = "./modules/security"
  region     = var.region
  vpc_id     = module.network.vpc_id
  my_ip_cidr = var.my_ip_cidr
}

# ─── 3. Storage: ECR repositories cho frontend & backend ───
module "storage" {
  source = "./modules/storage"
  region = var.region
}

# ─── 4. Database: MongoDB chạy trên EC2 (private subnet) ───
module "database" {
  source               = "./modules/database"
  region               = var.region
  vpc_id               = module.network.vpc_id
  private_subnet_ids   = module.network.private_subnet_ids
  mongodb_security_group_id = module.security.mongodb_security_group_id
  backend_security_group_id = module.security.backend_security_group_id
  key_name             = var.key_name
  instance_type        = var.mongodb_instance_type
  mongodb_volume_size  = var.mongodb_volume_size
}

# ─── 5. Application: ALB + ECS Cluster + 2 Service (frontend/backend) ───
module "application" {
  source                     = "./modules/application"
  region                     = var.region
  vpc_id                     = module.network.vpc_id
  public_subnet_ids          = module.network.public_subnet_ids
  private_subnet_ids         = module.network.private_subnet_ids
  alb_security_group_id      = module.security.alb_security_group_id
  frontend_security_group_id = module.security.frontend_security_group_id
  backend_security_group_id  = module.security.backend_security_group_id
  mongodb_host               = module.database.mongodb_private_ip

  frontend_ecr_image_uri = "${module.storage.frontend_repository_url}:${var.frontend_image_tag}"
  backend_ecr_image_uri  = "${module.storage.backend_repository_url}:${var.backend_image_tag}"

  frontend_desired_count = var.frontend_desired_count
  backend_desired_count  = var.backend_desired_count
}
