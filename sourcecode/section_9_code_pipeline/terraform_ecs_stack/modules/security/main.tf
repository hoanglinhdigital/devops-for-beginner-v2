# Security Group cho ALB: mở port 80 (production listener) và 81 (test listener cho Blue/Green)
resource "aws_security_group" "alb_sg" {
  name        = "codepipeline-lab-alb-sg"
  description = "Allow HTTP 80, 81 from Internet to ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "Production listener"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Test listener (Blue/Green)"
    from_port   = 81
    to_port     = 81
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

# Security Group cho ECS task: chỉ nhận traffic port 3000 từ ALB (SG chaining)
resource "aws_security_group" "ecs_sg" {
  name        = "codepipeline-lab-ecs-sg"
  description = "Allow port 3000 from ALB only"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Traffic from ALB"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Task cần outbound Internet để pull image từ ECR và ghi log CloudWatch
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
