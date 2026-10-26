resource "aws_ecs_cluster" "cluster" {
  name = "jenkins-lab-cluster"
}

resource "aws_cloudwatch_log_group" "nodejs" {
  name              = "/ecs/jenkins-lab-nodejs"
  retention_in_days = 7
}

#==========Task Execution Role==========
# Role cho ECS agent: pull image từ ECR, ghi log lên CloudWatch Logs
resource "aws_iam_role" "task_execution_role" {
  name = "jenkins-lab-task-execution-role"

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
resource "aws_ecs_task_definition" "nodejs" {
  family                   = "jenkins-lab-nodejs-task"
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
      # Tên container phải khớp với biến CONTAINER_NAME trong Jenkinsfile deploy (Lab 7 → Lab 10)
      name      = "nodejs-container"
      image     = var.ecr_image_uri
      essential = true
      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.nodejs.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "nodejs"
        }
      }
    }
  ])
}

#==========ECS Service==================
resource "aws_ecs_service" "nodejs" {
  name            = "nodejs-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.nodejs.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  # Lab dùng public subnet + public IP để task pull image từ ECR mà không cần NAT Gateway
  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "nodejs-container"
    container_port   = 3000
  }

  # Rolling update: task mới healthy rồi mới dừng task cũ
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  # Tự động rollback nếu task của version mới không khởi động được
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  # Jenkins đăng ký task definition revision mới mỗi lần deploy,
  # bỏ qua thay đổi này để terraform apply không rollback version đã deploy.
  lifecycle {
    ignore_changes = [task_definition]
  }
}
