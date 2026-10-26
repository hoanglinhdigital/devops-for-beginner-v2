# Sử dụng module VPC có sẵn trên Terraform Registry (xem lại Section 5 – Lab 7).
# Để tiết kiệm chi phí, bài lab chỉ dùng public subnet, KHÔNG tạo NAT Gateway.
# Task Fargate sẽ dùng public subnet + public IP để pull image từ ECR.
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "udemy-devops-vpc"
  cidr = var.cidr_block

  azs            = var.availability_zones
  public_subnets = var.public_subnet_ips

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Project = "udemy-devops"
  }
}
