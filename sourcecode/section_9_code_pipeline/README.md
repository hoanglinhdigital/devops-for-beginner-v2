# Section 9 – CI/CD với AWS CodePipeline

Source code cho các bài lab của Section 9. Nội dung hướng dẫn: `sections/section_9/`.

Các lab sử dụng 3 repository mẫu trên GitHub (học viên **fork** về account của mình ở Lab 1):

| Repository | Branch | Dùng cho |
|---|---|---|
| `hoanglinhdigital/java-elasticbeanstalk-sample` | `main` | Lab 2, Lab 5 (Spring Boot, port 5000) |
| `hoanglinhdigital/simple-vue-webpack` | `master` | Lab 3 (Vue + Webpack, build ra file tĩnh) |
| `hoanglinhdigital/nodejs-random-color` | `master` | Lab 4, Lab 6 → Lab 9 (Express, port 3000) |

Các file `buildspec.yml`, `Dockerfile`, `appspec.yaml`, `taskdef.json` trong thư mục này được **copy vào thư mục gốc
của repository đã fork**, sau đó commit & push. Các file `commands.sh` là **tập hợp lệnh tham khảo** theo thứ tự các bước,
không chạy cả file một lần — copy từng lệnh và chạy trong Git Bash / Terminal.

| Folder | Bài lab |
|---|---|
| `lab1_prepare_source/` | Lab 1 – Fork & clone repository mẫu, tạo GitHub connection (CodeConnections), S3 artifact bucket |
| `lab2_codebuild_java/` | Lab 2 – CodeBuild build Java (Maven, Corretto 17), artifact `.jar` lên S3 |
| `lab3_codebuild_nodejs/` | Lab 3 – CodeBuild build Node.js (Webpack), `aws s3 cp` file tĩnh lên S3 |
| `lab4_codebuild_docker/` | Lab 4 – CodeBuild build Docker image, push lên Amazon ECR (`Dockerfile` dùng base image ECR Public) |
| `lab5_pipeline_beanstalk/` | Lab 5 – CodePipeline: GitHub → CodeBuild → Elastic Beanstalk |
| `lab6_pipeline_ecs_rolling/` | Lab 6 – CodePipeline deploy lên ECS (rolling update, `imagedefinitions.json`) |
| `lab7_ecs_blue_green/` | Lab 7 – Blue/Green lên ECS với CodeDeploy (`appspec.yaml`, `taskdef.json`, `imageDetail.json`) |
| `lab8_ecs_canary/` | Lab 8 – Canary lên ECS với CodeDeploy (custom deployment configuration 25% / 5 phút) |
| `terraform_ecs_stack/` | Terraform stack dùng chung cho Lab 6 → Lab 9: VPC, ALB (listener 80 & 81, 2 Target Group), ECS Fargate |

Lab 9 (Manual approval & notification) thao tác hoàn toàn trên AWS Console, không có source code riêng.

## Terraform stack (`terraform_ecs_stack/`)
- Terraform >= 1.10, AWS provider `~> 6.0`, module `terraform-aws-modules/vpc/aws ~> 6.0`.
- Copy `terraform.tfvars.example` thành `terraform.tfvars` (đã gitignore) và điền `ecr_image_uri` của bạn.
- Biến `deployment_controller_type`: `ECS` cho Lab 6, `CODE_DEPLOY` cho Lab 7 và Lab 8.
- Để tiết kiệm chi phí: chỉ dùng public subnet + public IP cho task, **không** tạo NAT Gateway.
  Môi trường production nên đặt task ở private subnet (NAT Gateway hoặc VPC Endpoint).

## Lưu ý
- Không hard-code AWS Account ID: buildspec lấy Account ID bằng `aws sts get-caller-identity`, `taskdef.json` dùng placeholder `<AWS_ACCOUNT_ID>` được thay thế khi build.
- ALB tính phí theo giờ: chạy `terraform destroy` sau khi học xong Lab 6 → Lab 9.
- So với phiên bản cũ: dùng GitHub + AWS CodeConnections thay cho CodeCommit, CodeBuild image `amazonlinux-x86_64-standard:5.0`,
  `node:14` → `node:20` (ECR Public), bỏ đăng nhập Docker Hub qua Secrets Manager, pipeline type V2, bỏ NAT Gateway trong stack ECS.
