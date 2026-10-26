#Application Load Balancer – dùng chung cho cả 2 môi trường Blue & Green
resource "aws_lb" "alb" {
  name               = "bluegreen-lab-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  enable_deletion_protection = false
}

#Target Group cho từng môi trường: bluegreen-lab-tg-blue, bluegreen-lab-tg-green
resource "aws_lb_target_group" "env" {
  for_each = toset(var.environments)

  name                 = "bluegreen-lab-tg-${each.key}"
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

  tags = {
    Environment = each.key
  }
}

#Listener 80 – PRODUCTION: người dùng cuối truy cập. Ban đầu trỏ tới Blue.
resource "aws_lb_listener" "production" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.env["blue"].arn
  }

  # Job Jenkins switch traffic / canary sẽ đổi Target Group của listener,
  # bỏ qua thay đổi này để terraform apply không "switch" ngược traffic.
  lifecycle {
    ignore_changes = [default_action]
  }
}

#Listener 81 – TEST: team QA kiểm thử version mới trước khi switch. Ban đầu trỏ tới Green.
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
