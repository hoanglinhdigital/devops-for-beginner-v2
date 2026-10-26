locals {
  environments = ["blue", "green"]
}

# Application Load Balancer – dùng chung cho cả 2 môi trường Blue & Green
resource "aws_lb" "alb" {
  name               = "udemy-devops-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.load_balance_security_group_ids
  subnets            = var.load_balance_subnet_ids

  enable_deletion_protection = false
}

# Target Group cho từng môi trường: target-group-blue, target-group-green
resource "aws_lb_target_group" "env" {
  for_each = toset(local.environments)

  name                 = "target-group-${each.key}"
  port                 = 3000
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  target_type          = "ip"
  deregistration_delay = 30

  health_check {
    path                = "/"
    matcher             = "200-399"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 15
  }
}

# Listener 80 – PRODUCTION: người dùng cuối truy cập. Ban đầu trỏ tới Blue.
resource "aws_lb_listener" "production" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.env["blue"].arn
  }

  # Workflow "Switch ALB Traffic" sẽ đổi Target Group của listener,
  # bỏ qua thay đổi này để terraform apply không "switch" ngược traffic.
  lifecycle {
    ignore_changes = [default_action]
  }
}

# Listener 81 – TEST: team QA kiểm thử version mới trước khi switch. Ban đầu trỏ tới Green.
resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 81
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.env["green"].arn
  }

  lifecycle {
    ignore_changes = [default_action]
  }
}
