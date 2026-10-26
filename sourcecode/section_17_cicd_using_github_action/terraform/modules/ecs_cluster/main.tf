locals {
  environments = ["blue", "green"]
}

#==========ECS Cluster x2===============
# udemy-devops-cluster-blue, udemy-devops-cluster-green
resource "aws_ecs_cluster" "env" {
  for_each = toset(local.environments)

  name = "udemy-devops-cluster-${each.key}"
}

resource "aws_cloudwatch_log_group" "nodejs" {
  name              = "ecs/nodejs-log-group"
  retention_in_days = 7
}

#==========Task Execution Role==========
# Role cho ECS agent: pull image từ ECR, ghi log lên CloudWatch Logs
resource "aws_iam_role" "task_execution_role" {
  name = "nodejs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "ecs-tasks.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "task_execution_policy" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

#==========Task Definition==============
# Dùng chung 1 family cho cả 2 môi trường. Mỗi lần deploy, workflow "Deploy to ECS"
# đăng ký revision mới và chỉ cập nhật service của môi trường được chọn.
resource "aws_ecs_task_definition" "nodejs" {
  family                   = "nodejs-task-definition"
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name      = "nodejs-container"
      image     = var.nodejs_ecr_image_url
      essential = true
      cpu       = 256
      memory    = 512
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.nodejs.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "nodejs-container"
        }
      }
    }
  ])
}

#==========ECS Service x2===============
# Mỗi cluster có 1 service tên nodejs-service, gắn với Target Group cùng màu
resource "aws_ecs_service" "nodejs" {
  for_each = toset(local.environments)

  name            = "nodejs-service"
  cluster         = aws_ecs_cluster.env[each.key].id
  task_definition = aws_ecs_task_definition.nodejs.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  # Lab dùng public subnet + public IP để task pull image từ ECR mà không cần NAT Gateway
  network_configuration {
    subnets          = var.ecs_subnet_ids
    security_groups  = var.ecs_security_group_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = each.key == "blue" ? var.nodejs_target_group_arn_blue : var.nodejs_target_group_arn_green
    container_name   = "nodejs-container"
    container_port   = 3000
  }

  # Tự động rollback nếu task của version mới không khởi động được
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  # Workflow "Deploy to ECS" đăng ký task definition mới, "Clear ECS Resources" scale về 0,
  # bỏ qua 2 thay đổi này để terraform apply không ghi đè trạng thái do workflow tạo ra.
  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }
}
