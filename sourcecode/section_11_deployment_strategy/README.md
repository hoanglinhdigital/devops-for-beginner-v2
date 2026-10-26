# Section 11 – Chiến lược deployment

Source code cho các bài lab của Section 11. Nội dung hướng dẫn: `sections/section_11/`.

Các lab dùng lại **Jenkins server** của Section 10 (EC2 Ubuntu 24.04, IAM Role `jenkins-server-role`, Docker, jq, AWS CLI v2,
credential `github-ssh-key`) và repository `nodejs-random-color` (Express, port 3000) đã fork về GitHub account của bạn.
IAM Role `jenkins-server-role` cần **gắn thêm** policy `ElasticLoadBalancingFullAccess` để job đọc & sửa listener của ALB.

Các file `Jenkinsfile-*` được **dán vào ô Pipeline script** của job. Các file `commands.sh` là **tập hợp lệnh tham khảo**
theo thứ tự các bước, không chạy cả file một lần — copy từng lệnh và chạy trong Terminal.

| Folder | Bài lab | Job Jenkins |
|---|---|---|
| `lab1_build_and_stack/` | Lab 1 – Build image theo Git tag (`v2.0.0`) & triển khai Terraform stack Blue/Green | `bluegreen-job1-build` (`VERSION`) |
| `lab2_deploy_idle_env/` | Lab 2 – Deploy `v2.1.0` lên môi trường idle (Green), kiểm thử qua listener `:81` | `bluegreen-job2-deploy` (`VERSION`, `TARGET_ENV`) |
| `lab3_switch_traffic/` | Lab 3 – Switch traffic `:80` ↔ `:81`, rollback bằng cách chạy lại job | `bluegreen-job3-switch-traffic` |
| `lab4_clear_resource/` | Lab 4 – Scale ECS Service của môi trường cũ về 0 task | `bluegreen-job4-clear-resource` (`TARGET_ENV`) |
| `lab5_canary_weighted/` | Lab 5 – Canary `v2.2.0` bằng ALB weighted target group 10% → 50% → 100% | `bluegreen-job5-canary` (`CANARY_ENV`, `CANARY_WEIGHT`) |
| `terraform_bluegreen_stack/` | Terraform stack dùng chung Lab 1 → Lab 5 | – |

## Terraform stack (`terraform_bluegreen_stack/`)
- Terraform >= 1.10, AWS provider `~> 6.0`, module `terraform-aws-modules/vpc/aws ~> 6.0`.
- Copy `terraform.tfvars.example` thành `terraform.tfvars` (đã gitignore) và điền `ecr_image_uri` (image `v2.0.0` build ở Lab 1).
- Resource được tạo:

| Resource | Tên |
|---|---|
| VPC (2 public subnet, không NAT Gateway) | `bluegreen-lab-vpc` – `10.40.0.0/16` |
| Application Load Balancer | `bluegreen-lab-alb` |
| Listener `:80` – production (ban đầu → Blue) | – |
| Listener `:81` – test (ban đầu → Green) | – |
| Target Group x2 | `bluegreen-lab-tg-blue`, `bluegreen-lab-tg-green` |
| ECS Cluster x2 | `bluegreen-lab-cluster-blue`, `bluegreen-lab-cluster-green` |
| ECS Service (mỗi cluster 1 service, Fargate) | `nodejs-service` |
| Task definition family (dùng chung) | `bluegreen-lab-nodejs-task`, container `nodejs-container` |
| CloudWatch Log group | `/ecs/bluegreen-lab-nodejs` |

- Listener có `lifecycle { ignore_changes = [default_action] }`, ECS Service có `ignore_changes = [task_definition, desired_count]`
  để `terraform apply` không ghi đè trạng thái do các job Jenkins tạo ra (switch traffic, deploy, scale về 0).
- Để tiết kiệm chi phí: chỉ dùng public subnet + public IP cho task, **không** tạo NAT Gateway.

## Lưu ý
- Không hard-code AWS Account ID / ARN: job lấy Account ID bằng `aws sts get-caller-identity`, lấy ARN của ALB, listener,
  Target Group theo **tên** (`describe-load-balancers --names`, `describe-target-groups --names`) và **port** listener.
- Các job Deploy và Clear resource có bước **Safety check**: từ chối thao tác lên môi trường đang nhận traffic production.
- Chi phí: ALB + 4 task Fargate (2 môi trường x 2 task) + Public IPv4 + EC2 Jenkins tính phí theo giờ.
  Chạy `terraform destroy` ngay sau Lab 5, stop Jenkins server khi không học.
- So với phiên bản cũ: không hard-code Account ID / ALB ARN, listener tìm theo port thay vì thứ tự, kiểm tra target healthy
  trước khi switch, bước `input` xác nhận trước khi switch, scale service về 0 thay vì stop từng task,
  Terraform stack không NAT Gateway, thêm lab Canary bằng ALB weighted target group.
