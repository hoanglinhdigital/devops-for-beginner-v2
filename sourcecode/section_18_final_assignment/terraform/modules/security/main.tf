# Module security: Security Groups theo mô hình "SG chaining" (SG này làm source cho SG khác).
# Nguyên tắc least privilege: chỉ mở đúng port cần thiết, source càng hẹp càng tốt.

resource "aws_security_group" "alb" {
  name        = "final-assignment-alb-sg"
  description = "Security group cho Application Load Balancer (Internet-facing)"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP từ Internet"
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

  tags = { Name = "final-assignment-alb-sg" }
}

resource "aws_security_group" "frontend" {
  name        = "final-assignment-frontend-sg"
  description = "Security group cho ECS task frontend"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP từ ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "final-assignment-frontend-sg" }
}

resource "aws_security_group" "backend" {
  name        = "final-assignment-backend-sg"
  description = "Security group cho ECS task backend"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP từ frontend (qua ALB nội bộ)"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "final-assignment-backend-sg" }
}

resource "aws_security_group" "mongodb" {
  name        = "final-assignment-mongodb-sg"
  description = "Security group cho máy chạy MongoDB"
  vpc_id      = var.vpc_id

  ingress {
    description     = "MongoDB từ backend"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.backend.id]
  }

  ingress {
    description     = "SSH từ Bastion (chỉ mở khi cần troubleshoot)"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "final-assignment-mongodb-sg" }
}

resource "aws_security_group" "bastion" {
  name        = "final-assignment-bastion-sg"
  description = "Security group cho Bastion host (dùng để SSH vào MongoDB)"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH từ IP của bạn"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "final-assignment-bastion-sg" }
}
