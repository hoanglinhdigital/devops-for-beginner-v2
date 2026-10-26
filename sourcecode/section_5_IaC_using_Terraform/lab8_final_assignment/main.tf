terraform {
  required_version = ">= 1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Ubuntu 22.04 LTS mới nhất (Canonical) - dùng chung cho Bastion, App, MongoDB
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

#==========Keypair===================
resource "aws_key_pair" "udemy_keypair" {
  key_name   = "udemy-keypair"
  public_key = file(var.keypair_path)
}

#==========Network===================
module "network" {
  source = "./modules/network"

  availability_zones = var.availability_zones
  cidr_block         = var.cidr_block
  public_subnet_ips  = var.public_subnet_ips
  private_subnet_ips = var.private_subnet_ips
}

#==========Security==================
module "security" {
  source = "./modules/security"

  vpc_id         = module.network.vpc_id
  workstation_ip = var.workstation_ip
}

#==========Bastion===================
module "bastion" {
  source = "./modules/bastion"

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.bastion_instance_type
  key_name      = aws_key_pair.udemy_keypair.key_name
  subnet_id     = module.network.public_subnets[0]
  sg_id         = module.security.bastion_sg_id
}

#==========Storage (MongoDB)=========
module "storage" {
  source = "./modules/storage"

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.db_instance_type
  key_name      = aws_key_pair.udemy_keypair.key_name
  subnet_id     = module.network.private_subnets[0]
  sg_id         = module.security.mongodb_sg_id
}

#==========Application===============
module "application" {
  source = "./modules/application"

  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.app_instance_type
  key_name        = aws_key_pair.udemy_keypair.key_name
  vpc_id          = module.network.vpc_id
  public_subnets  = module.network.public_subnets
  private_subnets = module.network.private_subnets
  webserver_sg_id = module.security.application_sg_id
  alb_sg_id       = module.security.alb_sg_id
  mongodb_ip      = module.storage.private_ip
}
