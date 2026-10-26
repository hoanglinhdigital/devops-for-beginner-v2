#!/bin/bash
# Lab 7 – Blue/Green deployment lên ECS với CodeDeploy
# Tập hợp lệnh tham khảo, copy từng lệnh và chạy trong Git Bash / Terminal.

#===Bước 1: Chuyển deployment controller của ECS Service sang CODE_DEPLOY===
cd sourcecode/section_9_code_pipeline/terraform_ecs_stack
# Sửa terraform.tfvars: deployment_controller_type = "CODE_DEPLOY"
terraform plan
terraform apply
terraform output

#===Bước 2: Đưa appspec.yaml, taskdef.json, buildspec.yml của Lab 7 vào repository===
cd ~/codepipeline-labs/nodejs-random-color
# Copy 3 file trong thư mục lab7_ecs_blue_green đè lên file cùng tên ở thư mục gốc repository
git add appspec.yaml taskdef.json buildspec.yml
git commit -m "ci: add appspec and taskdef for ECS blue/green"
git push origin master

#===Bước 3: Sửa public/index.html, commit & push để trigger pipeline===
git add public/index.html
git commit -m "feat: update welcome message v3"
git push origin master

#===Bước 4: So sánh production listener (80) và test listener (81) – thay <alb-dns-name>===
curl -s http://<alb-dns-name>/ | grep -o "<h1[^>]*>[^<]*"
curl -s http://<alb-dns-name>:81/ | grep -o "<h1[^>]*>[^<]*"
