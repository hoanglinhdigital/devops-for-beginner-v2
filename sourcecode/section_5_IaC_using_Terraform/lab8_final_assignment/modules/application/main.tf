#==========Launch Template===========
resource "aws_launch_template" "apptemplate" {
  name = "application"

  image_id               = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.webserver_sg_id]

  # templatefile(): đọc file template và truyền giá trị biến vào
  user_data = base64encode(templatefile("${path.module}/userdata.sh.tftpl", {
    alb_dns    = aws_lb.alb1.dns_name
    mongodb_ip = var.mongodb_ip
  }))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name  = "FrontendApp"
      Owner = "Udemy"
    }
  }
}

#==========Application Load Balancer=
resource "aws_lb" "alb1" {
  name                       = "udemy-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.alb_sg_id]
  subnets                    = var.public_subnets
  drop_invalid_header_fields = true
  enable_deletion_protection = false

  tags = {
    Environment = "Lab"
  }
}

resource "aws_lb_target_group" "webserver" {
  name     = "udemy-tg-webserver"
  vpc_id   = var.vpc_id
  port     = 80
  protocol = "HTTP"

  health_check {
    path                = "/"
    interval            = 10
    healthy_threshold   = 3
    unhealthy_threshold = 6
    timeout             = 5
  }
}

resource "aws_lb_target_group" "api" {
  name     = "udemy-tg-api"
  vpc_id   = var.vpc_id
  port     = 8080
  protocol = "HTTP"

  health_check {
    path                = "/ok"
    interval            = 10
    healthy_threshold   = 3
    unhealthy_threshold = 6
    timeout             = 5
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb1.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webserver.arn
  }
}

resource "aws_lb_listener_rule" "frontend_rule1" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webserver.arn
  }
}

# Request tới API được chuyển tới target group port 8080
resource "aws_lb_listener_rule" "api_rule1" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 10

  condition {
    path_pattern {
      values = [
        "/languages",
        "/languages/*",
        "/languages/*/*",
        "/ok"
      ]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }
}

#==========Auto Scaling Group========
resource "aws_autoscaling_group" "asg" {
  name                = "udemy-app-asg"
  vpc_zone_identifier = var.private_subnets

  desired_capacity = var.asg_desired
  max_size         = var.asg_max_size
  min_size         = var.asg_min_size

  target_group_arns = [aws_lb_target_group.webserver.arn, aws_lb_target_group.api.arn]

  launch_template {
    id      = aws_launch_template.apptemplate.id
    version = "$Latest"
  }
}

data "aws_instances" "application" {
  instance_tags = {
    Name  = "FrontendApp"
    Owner = "Udemy"
  }

  instance_state_names = ["pending", "running"]

  depends_on = [
    aws_autoscaling_group.asg
  ]
}
