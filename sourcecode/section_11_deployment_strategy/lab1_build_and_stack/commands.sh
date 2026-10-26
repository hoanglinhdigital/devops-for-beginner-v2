#!/bin/bash
# Lab 1 – Job Build theo Git tag & triển khai Terraform stack Blue/Green
# Tập hợp lệnh tham khảo, không chạy cả file một lần – copy từng lệnh và chạy trong Terminal (Git Bash).

#===Bước 1: Kiểm tra ECR repository (tạo trên Console nếu đã xoá ở cuối Section 10)===
aws ecr describe-repositories --repository-names nodejs-random-color --region ap-southeast-1 --query 'repositories[0].repositoryUri' --output text

#===Bước 2: Kiểm tra quyền của Jenkins server sau khi gắn thêm policy ElasticLoadBalancingFullAccess (chạy trên Jenkins server qua SSH)===
sudo -u jenkins aws elbv2 describe-load-balancers --region ap-southeast-1 --query 'LoadBalancers[].LoadBalancerName'

#===Bước 4: Sửa code & tạo tag v2.0.0 (chạy trong repository nodejs-random-color trên máy local)===
cd ~/jenkins-labs/nodejs-random-color
git checkout master
git pull origin master
# Sửa text thẻ <h1 id="welcome" ...> trong public/index.html thành: Welcome to My Website – v2.0.0
git add public/index.html
git commit -m "feat: release v2.0.0"
git push origin master
git tag -a v2.0.0 -m "Release v2.0.0"
git push origin v2.0.0

#===Bước 5: Kiểm tra image v2.0.0 trên ECR sau khi chạy job bluegreen-job1-build===
aws ecr list-images --repository-name nodejs-random-color --region ap-southeast-1 --query 'imageIds[].imageTag'

#===Bước 6: Cấu hình biến & triển khai Terraform stack===
cd sourcecode/section_11_deployment_strategy/terraform_bluegreen_stack
cp terraform.tfvars.example terraform.tfvars
aws sts get-caller-identity --query Account --output text
# Mở terraform.tfvars, sửa ecr_image_uri, ví dụ:
# ecr_image_uri = "123456789012.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-random-color:v2.0.0"
terraform init
terraform plan
terraform apply
terraform output

#===Bước 7: Truy cập production (:80) & test (:81)===
curl -s $(terraform output -raw production_url)/ | grep -o "<h1[^>]*>[^<]*"
curl -s $(terraform output -raw test_url)/ | grep -o "<h1[^>]*>[^<]*"

#===Kiểm tra listener của ALB đang trỏ tới Target Group nào===
ALB_ARN=$(aws elbv2 describe-load-balancers --names bluegreen-lab-alb --region ap-southeast-1 --query 'LoadBalancers[0].LoadBalancerArn' --output text)
aws elbv2 describe-listeners --load-balancer-arn $ALB_ARN --region ap-southeast-1 --query 'Listeners[].{port:Port,targetGroups:DefaultActions[0].ForwardConfig.TargetGroups}'
