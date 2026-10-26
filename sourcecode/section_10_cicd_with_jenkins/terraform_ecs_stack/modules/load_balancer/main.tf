#Application Load Balancer
resource "aws_lb" "alb" {
  name               = "jenkins-lab-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  enable_deletion_protection = false
}

#Target Group cho ECS task (target type ip – bắt buộc với Fargate)
resource "aws_lb_target_group" "nodejs" {
  name                 = "jenkins-lab-nodejs-tg"
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

#Listener 80 – forward toàn bộ traffic tới Target Group
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nodejs.arn
  }
}
