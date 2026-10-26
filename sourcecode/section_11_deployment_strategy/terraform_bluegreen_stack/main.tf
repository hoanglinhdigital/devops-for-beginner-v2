terraform {
  required_version = ">= 1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  # Để bài lab đơn giản, sử dụng local state (xem lại Section 5 – Lab 9 nếu muốn dùng S3 backend)
}

provider "aws" {
  region = var.region
}

# Hai môi trường song song của chiến lược Blue/Green.
# Mỗi môi trường có 1 ECS Cluster + 1 ECS Service + 1 Target Group riêng.
locals {
  environments = ["blue", "green"]
}

#==========Networking===================
module "networking" {
  source = "./modules/networking"

  availability_zones = var.availability_zones
  cidr_block         = var.cidr_block
  public_subnet_ips  = var.public_subnet_ips
}

#==========Security Group===============
module "security" {
  source = "./modules/security"

  vpc_id = module.networking.vpc_id
}

#==========Load Balancer================
module "load_balancer" {
  source = "./modules/load_balancer"

  vpc_id             = module.networking.vpc_id
  subnet_ids         = module.networking.public_subnet_ids
  security_group_ids = [module.security.alb_security_group_id]
  environments       = local.environments
}

#==========ECS Cluster x2 + Service x2==
module "ecs" {
  source = "./modules/ecs"

  region             = var.region
  subnet_ids         = module.networking.public_subnet_ids
  security_group_ids = [module.security.ecs_security_group_id]
  environments       = local.environments
  target_group_arns  = module.load_balancer.target_group_arns
  ecr_image_uri      = var.ecr_image_uri
  desired_count      = var.desired_count

  # Service chỉ được tạo sau khi listener đã gắn Target Group vào ALB
  depends_on = [module.load_balancer]
}
