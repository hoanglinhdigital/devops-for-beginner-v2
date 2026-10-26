terraform {
  required_version = ">= 1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  # Lưu state trên S3 bucket. Đổi tên bucket thành bucket bạn đã tạo ở Bước 1
  backend "s3" {
    bucket       = "udemy-terraform-state-change-me"
    key          = "lab9/terraform.tfstate"
    region       = "ap-southeast-1"
    encrypt      = true
    use_lockfile = true # S3 native state locking (Terraform >= 1.10), không cần DynamoDB
  }
}

provider "aws" {
  region = var.region
}

# PART 1: Create a complete VPC using module networking
module "networking" {
  source              = "./modules/networking"
  name_prefix         = var.name_prefix
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
  cidr_block          = var.cidr_block
  public_subnet_ips   = var.public_subnet_ips
  private_subnet_ips  = var.private_subnet_ips
}

# PART 2: Security + Compute deploy vào VPC vừa tạo
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_key_pair" "udemy_keypair" {
  key_name   = "${var.name_prefix}-keypair"
  public_key = file(var.keypair_path)
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
}

module "compute" {
  source                 = "./modules/compute"
  image_id               = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.udemy_keypair.key_name
  subnet_id              = module.networking.public_subnet_ids[0]
  ec2_security_group_ids = [module.security.public_security_group_id]
}
