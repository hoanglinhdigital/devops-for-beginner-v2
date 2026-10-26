# Section 18 — Final Assignment: Container Architecture

Source code tham khảo cho **Final Assignment #1 – Container Architecture**. Đây là bộ code "đáp án mẫu"
minh hoạ cách triển khai ứng dụng full-stack `react-spring-mongo-full-stack-demo` (React + Spring Boot + MongoDB)
lên AWS theo kiến trúc Container. Nội dung hướng dẫn: `sections/section_18/`.

> Assignment là bài tập MỞ — bạn không bắt buộc phải giống 100% đáp án mẫu. Điều quan trọng là hiểu được
> **tại sao** lại thiết kế như vậy và áp dụng đúng các Best Practice của AWS.

## Ứng dụng mẫu

Repository của đề bài (đọc kỹ README của repo này trước khi làm):

```
https://github.com/hoanglinhdigital/react-spring-mongo-full-stack-demo
```

| Thành phần | Công nghệ | Port | Ghi chú |
|---|---|---|---|
| Frontend | React (chạy bằng Node.js / nginx) | 3000 (dev) / 80 | Build ra file tĩnh rồi chạy nginx, hoặc chạy `npm start` |
| Backend | Spring Boot (Java) | 8080 | Kết nối MongoDB, expose REST API |
| Database | MongoDB | 27017 | Lưu dữ liệu, chạy độc lập trên EC2 (hoặc DocumentDB) |

## Cấu trúc thư mục

```
section_18_final_assignment/
├── docker/
│   ├── Dockerfile.frontend        # Build React rồi chạy nginx
│   └── Dockerfile.backend         # Build Spring Boot (JAR) rồi chạy java -jar
├── terraform/
│   ├── main.tf                    # Gọi các module + khai báo provider
│   ├── variable.tf                # Biến đầu vào
│   ├── output.tf                  # Output (DNS ALB, ECR URI...)
│   ├── terraform.tfvars.example   # File biến mẫu (copy thành terraform.tfvars)
│   ├── command.sh                 # Các lệnh triển khai
│   └── modules/
│       ├── network/               # VPC, subnet, IGW, NAT Gateway
│       ├── security/              # Security Groups
│       ├── storage/               # ECR repositories
│       ├── database/              # MongoDB trên EC2 (private subnet)
│       └── application/           # ALB + ECS Cluster + 2 Service (frontend/backend)
└── cicd/
    ├── jenkins/
    │   └── Jenkinsfile            # Pipeline build + push ECR + deploy ECS
    └── codepipeline/
        ├── buildspec.yml          # Build Docker image + push ECR
        └── imagedefinitions.json  # Artifact cho action Deploy ECS
```

## Kiến trúc tổng quan

Thiết kế theo mô hình 3 tầng, chạy container trên **Amazon ECS (Fargate)**:

- **Tầng trình bày (Frontend):** React đóng gói thành Docker image, chạy trên ECS, đứng sau ALB public.
- **Tầng ứng dụng (Backend):** Spring Boot đóng gói thành Docker image, chạy trên ECS (private subnet),
  chỉ nhận request từ ALB nội bộ, gọi xuống MongoDB.
- **Tầng dữ liệu (MongoDB):** chạy trên EC2 ở private subnet, dữ liệu lưu trên EBS volume.

Xem chi tiết các sơ đồ thiết kế trong `sections/section_18/chapter_2.html` (đáp án mẫu phần thiết kế).

## Yêu cầu

- AWS CLI v2 đã cấu hình profile (`aws configure`).
- Terraform >= 1.6.
- Docker (để build image ở bước chuẩn bị).
- Đã có cặp key pair EC2 (dùng để SSH vào máy chạy MongoDB nếu cần troubleshoot).

## Các bước triển khai nhanh

```bash
# 1. Chuẩn bị source code
git clone https://github.com/hoanglinhdigital/react-spring-mongo-full-stack-demo

# 2. Build Docker image (xem file docker/)
#    - frontend -> docker build -f docker/Dockerfile.frontend -t frontend .
#    - backend  -> docker build -f docker/Dockerfile.backend  -t backend  .

# 3. Tạo ECR repos + push image (xem chapter_3)

# 4. Deploy hạ tầng bằng Terraform
cd terraform
cp terraform.tfvars.example terraform.tfvars   # điền các giá trị
terraform init
terraform plan  --var-file terraform.tfvars
terraform apply --var-file terraform.tfvars

# 5. Cấu hình CICD (Jenkins hoặc CodePipeline) - xem thư mục cicd/

# 6. Dọn dẹp sau khi học xong
terraform destroy --var-file terraform.tfvars
```

## Lưu ý về chi phí

- **ALB, NAT Gateway, ECS Fargate task, EBS, Elastic IP** đều tính phí theo giờ/GB kể cả khi không có traffic.
- NAT Gateway là một trong những thành phần tốn kém nhất trong bài này — hãy nhớ `terraform destroy`
  ngay sau khi thực hành xong.
- MongoDB self-managed trên EC2 chỉ để học; trong thực tế có thể cân nhắc **Amazon DocumentDB**
  (tương thích MongoDB) để giảm công sức vận hành.
