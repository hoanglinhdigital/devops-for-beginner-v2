#!/bin/bash
# Lab 6 – CodePipeline deploy lên ECS (Rolling update)
# Tập hợp lệnh tham khảo, copy từng lệnh và chạy trong Git Bash / Terminal.

#===Bước 1: Triển khai stack VPC + ALB + ECS bằng Terraform===
cd sourcecode/section_9_code_pipeline/terraform_ecs_stack
cp terraform.tfvars.example terraform.tfvars
# Sửa terraform.tfvars: ecr_image_uri = Image URI tag latest của Lab 4, deployment_controller_type = "ECS"
terraform init
terraform plan
terraform apply
terraform output alb_dns_name

#===Bước 2: Truy cập thử website qua ALB (thay <alb-dns-name>)===
curl -s http://<alb-dns-name>/ | grep "<h1"

#===Bước 3: Cập nhật buildspec.yml trong repository nodejs-random-color===
cd ~/codepipeline-labs/nodejs-random-color
# Copy nội dung file lab6_pipeline_ecs_rolling/buildspec.yml đè lên buildspec.yml trong repository
git add buildspec.yml
git commit -m "ci: generate imagedefinitions.json for ECS deploy"
git push origin master

#===Bước 4: Sửa public/index.html (đổi text thẻ <h1>), commit & push để trigger pipeline===
git add public/index.html
git commit -m "feat: update welcome message v2"
git push origin master

#===Bước 5: Theo dõi rolling update – gọi ALB liên tục (Ctrl + C để dừng)===
while true; do curl -s http://<alb-dns-name>/ | grep -o "<h1[^>]*>[^<]*"; sleep 1; done
