# Section 5 – Infra as Code (IaC) sử dụng Terraform

Source code cho các bài lab của Section 5. Nội dung hướng dẫn: `sections/section_5/`.

| Folder | Bài lab |
|---|---|
| `keypair/` | Nơi chứa keypair do bạn tự sinh (`ssh-keygen`), dùng chung cho mọi lab |
| `lab2_ec2_basic/` | Lab 2 – Template đơn giản: EC2 + Security Group |
| `lab3_variables/` | Lab 3 – Variable, Map, Variable file |
| `lab4_outputs/` | Lab 4 – Terraform Output |
| `lab5_modules/` | Lab 5 – Chia module security + compute |
| `lab6_vpc_complete/` | Lab 6 – VPC hoàn chỉnh + security + compute |
| `lab7_registry_module/` | Lab 7 – Dùng module có sẵn từ Terraform Registry |
| `lab8_final_assignment/` | Lab 8 – Bài tập cuối chương (ALB, ASG, MongoDB, Bastion) |
| `lab9_s3_backend/` | Lab 9 – Lưu Terraform state trên S3 |
| `lab10_multi_env/` | Lab 10 – Multi environment / multi region |

## Lưu ý
- File `terraform.tfvars` bị `.gitignore` của repo bỏ qua, vì vậy mỗi lab có file `terraform.tfvars.example`.
  Copy thành `terraform.tfvars` trước khi chạy: `cp terraform.tfvars.example terraform.tfvars`
- Luôn chạy `terraform destroy` sau khi thực hành để tránh phát sinh chi phí (đặc biệt NAT Gateway, ALB).
