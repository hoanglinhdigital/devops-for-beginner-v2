# Section 17 – CI/CD sử dụng GitHub Actions

Source code cho các bài lab của Section 17. Nội dung hướng dẫn: `sections/section_17/`.

Các lab dùng lại repository `nodejs-random-color` (Express, port 3000, nhánh `master` + `develop`) — các bạn có thể
fork từ `https://github.com/hoanglinhdigital/nodejs-random-color`. Trên AWS cần có IAM User (quyền `PowerUserAccess`)
với Access Key được lưu vào **GitHub Secrets** của repository (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`).

Các file `*.yml` là workflow GitHub Actions — **copy vào thư mục `.github/workflows/`** của repository rồi chỉnh sửa.
Terraform stack tạo hạ tầng Blue/Green trên ECS (VPC, ALB, 2 Target Group, 2 ECS Cluster).

| Folder | Bài lab | Workflow | Ghi chú |
|---|---|---|---|
| `lab1_build_docker_ecr/` | Lab 1 – Build Docker image & push lên ECR | `build-docker-v1.yml` (auto, tag `latest`), `build-docker-v2.yml` (manual/theo tag) | Lưu thành `build-docker.yml` |
| `lab2_deploy_ecs/` | Lab 2 – Deploy lên ECS Cluster | `deploy-ecs.yml` | Lưu thành `deploy-ecs.yml` |
| `lab3_switch_traffic/` | Lab 3 – Switch traffic trên ALB | `switch-traffic.yml` | Lưu thành `switch-traffic.yml` |
| `lab4_clear_old_resource/` | Lab 4 – Clear old resources | `clear-resources.yml` | Lưu thành `clear-resources.yml` |
| `lab5_combine_all_actions/` | Lab 5 – Kết hợp tất cả trong 1 workflow | `blue-green-deployment.yml` | Gọi 4 workflow trên bằng `workflow_call` |
| `lab6_add_test_step/` | Lab 6 – Thêm bước test khi push/PR vào `develop` | `test-on-develop.yml` | Lưu thành `test-on-develop.yml` |
| `terraform/` | Terraform stack tạo hạ tầng Blue/Green (dùng ở Lab 2) | – | Xem `terraform/command.sh` |

## Terraform stack (`terraform/`)
- Terraform >= 1.5, AWS provider >= 5.0, module `terraform-aws-modules/vpc/aws ~> 5.0`.
- Copy `terraform.tfvars.example` thành `terraform.tfvars` (đã gitignore) và điền `ecr_image_uri` (image build ở Lab 1).
- Resource được tạo:

| Resource | Tên |
|---|---|
| VPC (2 public subnet, không NAT Gateway) | `udemy-devops-vpc` – `10.0.0.0/16` |
| Application Load Balancer | `udemy-devops-alb` |
| Listener `:80` – production (ban đầu → Blue) | – |
| Listener `:81` – test (ban đầu → Green) | – |
| Target Group x2 | `target-group-blue`, `target-group-green` |
| ECS Cluster x2 | `udemy-devops-cluster-blue`, `udemy-devops-cluster-green` |
| ECS Service (mỗi cluster 1 service, Fargate) | `nodejs-service` |
| Task definition family (dùng chung) | `nodejs-task-definition`, container `nodejs-container` |
| CloudWatch Log group | `ecs/nodejs-log-group` |

- Listener có `lifecycle { ignore_changes = [default_action] }`, ECS Service có `ignore_changes = [task_definition, desired_count]`
  để `terraform apply` không ghi đè trạng thái do các workflow GitHub Actions tạo ra (switch traffic, deploy, scale về 0).
- Để tiết kiệm chi phí: chỉ dùng public subnet + public IP cho task, **không** tạo NAT Gateway.

## Lưu ý
- Không hard-code AWS Account ID / ARN: workflow lấy Account ID bằng `aws sts get-caller-identity`, lấy ARN của ALB theo
  **tên** (`describe-load-balancers --names`), lấy listener theo **port** (80/81).
- Workflow `build-docker-v2.yml` dùng `amazon-ecr-login` — output `registry` chính là URI của ECR registry, không cần
  khai báo `ECR_REGISTRY` thủ công.
- Lab 5 dùng **Environment `production-approval`** có required reviewer cho bước manual-approval trước khi switch traffic.
- Chi phí: ALB + 4 task Fargate (2 môi trường x 2 task) + Public IPv4 tính phí theo giờ. Chạy `terraform destroy` ngay
  sau khi học xong (xem Section 17 – Tổng kết & Clear resources).
