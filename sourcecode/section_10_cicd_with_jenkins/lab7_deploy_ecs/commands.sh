#!/bin/bash
# Lab 7 – Triển khai Terraform stack (VPC, ALB, ECS Fargate) & test job deploy
# Tập hợp lệnh tham khảo, chạy trên máy local (Git Bash / Terminal) đã cài Terraform >= 1.10, AWS CLI v2.

#===Bước 1: Cấu hình biến cho Terraform stack===
cd sourcecode/section_10_cicd_with_jenkins/terraform_ecs_stack
cp terraform.tfvars.example terraform.tfvars
# Mở terraform.tfvars, sửa ecr_image_uri thành image tag đã push ở Lab 6, ví dụ:
# ecr_image_uri = "123456789012.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-random-color:ver-1"
aws sts get-caller-identity --query Account --output text
aws ecr list-images --repository-name nodejs-random-color --region ap-southeast-1

#===Bước 2: Triển khai stack===
terraform init
terraform plan
terraform apply
terraform output

#===Bước 3: Truy cập website qua ALB===
curl -s http://$(terraform output -raw alb_dns_name)/ | grep -o "<h1[^>]*>[^<]*"

#===Bước 5: Sửa code & build image mới (chạy trong repository nodejs-random-color)===
cd ~/jenkins-labs/nodejs-random-color
git add public/index.html
git commit -m "feat: update welcome message v2"
git push origin master

#===Bước 7: Quan sát rolling update (thay <alb-dns-name>, Ctrl + C để dừng)===
while true; do curl -s http://<alb-dns-name>/ | grep -o "<h1[^>]*>[^<]*"; sleep 1; done

#===Kiểm tra revision của task definition & deployment của service===
aws ecs list-task-definitions --family-prefix jenkins-lab-nodejs-task --region ap-southeast-1
aws ecs describe-services --cluster jenkins-lab-cluster --services nodejs-service --region ap-southeast-1 --query 'services[0].deployments[].{status:status,taskDef:taskDefinition,running:runningCount,rollout:rolloutState}'

#===Troubleshoot: jq: command not found (chạy trên Jenkins server)===
sudo apt install -y jq

#===Dọn dẹp (khi không học tiếp Lab 8 → Lab 10)===
cd sourcecode/section_10_cicd_with_jenkins/terraform_ecs_stack
terraform destroy
