#!/bin/bash
# Lab 4 – Clear resource môi trường cũ & tổng kết quy trình release Blue/Green
# Tập hợp lệnh tham khảo, chạy trên máy local (Git Bash / Terminal).

#===Kiểm tra số task của 2 môi trường===
aws ecs describe-services --cluster bluegreen-lab-cluster-blue --services nodejs-service --region ap-southeast-1 --query 'services[0].{desired:desiredCount,running:runningCount}'
aws ecs describe-services --cluster bluegreen-lab-cluster-green --services nodejs-service --region ap-southeast-1 --query 'services[0].{desired:desiredCount,running:runningCount}'

#===Danh sách task đang chạy trên cluster blue (rỗng sau khi clear)===
aws ecs list-tasks --cluster bluegreen-lab-cluster-blue --region ap-southeast-1

#===Target health của Target Group blue (rỗng sau khi clear)===
TG_BLUE_ARN=$(aws elbv2 describe-target-groups --names bluegreen-lab-tg-blue --region ap-southeast-1 --query 'TargetGroups[0].TargetGroupArn' --output text)
aws elbv2 describe-target-health --target-group-arn $TG_BLUE_ARN --region ap-southeast-1 --query 'TargetHealthDescriptions[].TargetHealth.State'

#===Test listener :81 sau khi clear (thay <alb-dns-name>) – kết quả 503 là đúng===
curl -s -o /dev/null -w '%{http_code}\n' http://<alb-dns-name>:81/
