#!/bin/bash
# Lab 9 – Push image lên Amazon ECR & chạy container trên Amazon ECS (Fargate)
# Dùng lại Dockerfile của Lab 3 (lab3_dockerfile)
# Thay <AWS_ACCOUNT_ID> bằng account ID của bạn (12 chữ số)

AWS_REGION=ap-southeast-1
AWS_ACCOUNT_ID=<AWS_ACCOUNT_ID>
ECR_REGISTRY=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
ECR_REPO=my-httpd

# Kiểm tra AWS CLI đã cấu hình đúng account
aws sts get-caller-identity

# Build image (chỉ định platform linux/amd64 để chạy trên Fargate X86_64, kể cả khi build trên Mac chip Apple Silicon)
cd lab3_dockerfile
docker build --platform linux/amd64 -t my-httpd-image:1.0 .

# Đăng nhập Docker vào ECR (token có hiệu lực 12 giờ)
aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY}

# Đánh tag image theo địa chỉ ECR repository
docker tag my-httpd-image:1.0 ${ECR_REGISTRY}/${ECR_REPO}:1.0
docker images

# Push image lên ECR
docker push ${ECR_REGISTRY}/${ECR_REPO}:1.0

# Liệt kê image trên ECR
aws ecr list-images --repository-name ${ECR_REPO} --region ${AWS_REGION}

# Pull lại image từ ECR để kiểm tra
docker rmi ${ECR_REGISTRY}/${ECR_REPO}:1.0
docker pull ${ECR_REGISTRY}/${ECR_REPO}:1.0

# (Tuỳ chọn) Version 2.0: sửa web/index.html, build, tag & push
docker build --platform linux/amd64 -t my-httpd-image:2.0 .
docker tag my-httpd-image:2.0 ${ECR_REGISTRY}/${ECR_REPO}:2.0
docker push ${ECR_REGISTRY}/${ECR_REPO}:2.0

# Dọn dẹp image local
docker rmi my-httpd-image:1.0 my-httpd-image:2.0 ${ECR_REGISTRY}/${ECR_REPO}:1.0 ${ECR_REGISTRY}/${ECR_REPO}:2.0
docker logout ${ECR_REGISTRY}
