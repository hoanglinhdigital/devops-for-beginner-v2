#Application Load Balancer
resource "aws_lb" "alb" {
  name               = "codepipeline-lab-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  enable_deletion_protection = false
}

#Target Group Blue – nhận traffic production ban đầu
resource "aws_lb_target_group" "blue" {
  name                 = "nodejs-tg-blue"
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

#Target Group Green – dùng cho version mới khi deploy Blue/Green, Canary
resource "aws_lb_target_group" "green" {
  name                 = "nodejs-tg-green"
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

#Listener 80 – production traffic
resource "aws_lb_listener" "production" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }

  # CodeDeploy sẽ đổi Target Group của listener khi switch traffic,
  # bỏ qua thay đổi này để terraform apply lần sau không ghi đè lại.
  lifecycle {
    ignore_changes = [default_action]
  }
}

#Listener 81 – test traffic, kiểm tra version mới trước khi switch (Blue/Green)
resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 81
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.green.arn
  }

  lifecycle {
    ignore_changes = [default_action]
  }
}
