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
  region = "ap-southeast-1"
}

# Data source: tra cứu AMI Amazon Linux 2023 mới nhất (không cần hard-code AMI ID)
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# Đăng ký public key lên AWS để SSH vào EC2
resource "aws_key_pair" "udemy_keypair" {
  key_name   = "udemy-keypair"
  public_key = file("../keypair/udemy-key.pub")
}

resource "aws_security_group" "demo_sg" {
  name        = "demo-security-group"
  description = "Allow HTTP, HTTPS, SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "demo_instance" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.udemy_keypair.key_name
  vpc_security_group_ids = [aws_security_group.demo_sg.id]

  tags = {
    Name   = "Udemy Demo"
    Domain = "DevOps"
  }
}
