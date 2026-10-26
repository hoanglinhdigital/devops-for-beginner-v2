terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
  # Để bài lab đơn giản, sử dụng local state (xem lại Section 5 – Lab 9 nếu muốn dùng S3 backend)
}

provider "aws" {
  region = var.region
}

# Hai môi trường song song của chiến lược Blue/Green:
# Blue nhận traffic production (listener :80), Green là môi trường test (listener :81).

module "networking" {
  source              = "./modules/networking"
  region              = var.region
  availability_zones  = var.availability_zones
  cidr_block          = var.cidr_block
  public_subnet_ips   = var.public_subnet_ips
}

module "security" {
  source = "./modules/security"
  region = var.region
  vpc_id = module.networking.vpc_id
}

module "load_balance" {
  source                 = "./modules/load_balance"
  region                 = var.region
  vpc_id                 = module.networking.vpc_id
  load_balance_subnet_ids = module.networking.public_subnet_ids
  load_balance_security_group_ids = [
    module.security.alb_security_group_id
  ]
}

module "ecs_cluster" {
  source               = "./modules/ecs_cluster"
  region               = var.region
  vpc_id               = module.networking.vpc_id
  ecs_subnet_ids       = module.networking.public_subnet_ids
  ecs_security_group_ids = [
    module.security.ecs_security_group_id
  ]
  alb_arn                    = module.load_balance.alb_arn
  nodejs_target_group_arn_blue  = module.load_balance.target_group_blue_arn
  nodejs_target_group_arn_green = module.load_balance.target_group_green_arn
  nodejs_ecr_image_url       = var.ecr_image_uri
  desired_count              = var.desired_count
}
