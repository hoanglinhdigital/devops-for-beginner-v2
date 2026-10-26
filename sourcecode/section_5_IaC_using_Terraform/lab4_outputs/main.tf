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

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_key_pair" "udemy_keypair" {
  key_name   = "udemy-keypair-${var.environment}"
  public_key = file(var.keypair_path)
}

resource "aws_security_group" "demo_sg" {
  name        = "demo-sg-${var.environment}"
  description = "Allow HTTP, SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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
  instance_type          = var.instance_types[var.environment]
  key_name               = aws_key_pair.udemy_keypair.key_name
  vpc_security_group_ids = [aws_security_group.demo_sg.id]

  # merge(): gộp tag chung (từ biến) với tag riêng của resource
  tags = merge(var.tags, {
    Name        = "udemy-demo-${var.environment}"
    Environment = var.environment
  })
}

# Elastic IP: IP public cố định, không đổi khi stop/start EC2
resource "aws_eip" "demo_eip" {
  instance = aws_instance.demo_instance.id
  domain   = "vpc"
}
