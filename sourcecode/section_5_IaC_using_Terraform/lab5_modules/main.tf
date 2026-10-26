terraform {
  required_version = ">= 1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Provider chỉ khai báo ở root module, các sub-module sẽ kế thừa
provider "aws" {
  region = var.region
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_key_pair" "udemy_keypair" {
  key_name   = "udemy-keypair"
  public_key = file(var.keypair_path)
}

module "security" {
  source = "./modules/security"
}

module "compute" {
  source        = "./modules/compute"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.udemy_keypair.key_name
  # Output của module security trở thành input của module compute
  ec2_security_group_ids = [module.security.public_security_group_id]
}
