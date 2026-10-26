# Module storage: ECR repositories lưu Docker image của frontend & backend.

resource "aws_ecr_repository" "frontend" {
  name                 = "final-assignment-frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = { Name = "final-assignment-frontend" }
}

resource "aws_ecr_repository" "backend" {
  name                 = "final-assignment-backend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = { Name = "final-assignment-backend" }
}
