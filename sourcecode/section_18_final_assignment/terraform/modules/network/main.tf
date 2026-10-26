# Module network: VPC 3 tầng (2 public + 2 private subnet), IGW + NAT Gateway.
# Dùng module VPC có sẵn trên Terraform Registry (xem lại Section 5 – Lab 7).
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "final-assignment-vpc"
  cidr = var.cidr_block

  azs             = var.availability_zones
  public_subnets  = var.public_subnet_ips
  private_subnets = var.private_subnet_ips

  # Mỗi AZ một NAT Gateway để đảm bảo high availability cho private subnet.
  # LƯU Ý: NAT Gateway tính phí theo giờ — nhớ destroy khi học xong.
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Project = "final-assignment"
  }
}
