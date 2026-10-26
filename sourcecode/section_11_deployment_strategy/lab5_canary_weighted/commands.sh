#!/bin/bash
# Lab 5 – Canary deployment với ALB weighted target group
# Tập hợp lệnh tham khảo, chạy trên máy local (Git Bash / Terminal).

#===Bước 1: Sửa code & tạo tag v2.2.0 (trong repository nodejs-random-color)===
cd ~/jenkins-labs/nodejs-random-color
# Sửa text thẻ <h1 id="welcome" ...> trong public/index.html thành: Welcome to My Website – v2.2.0
git add public/index.html
git commit -m "feat: release v2.2.0"
git push origin master
git tag -a v2.2.0 -m "Release v2.2.0"
git push origin v2.2.0

#===Đo tỷ lệ traffic: gửi 100 request tới production, đếm theo version (thay <alb-dns-name>)===
for i in $(seq 1 100); do curl -s http://<alb-dns-name>/ | grep -o '<h1[^>]*>[^<]*' | grep -o 'v[0-9.]*'; done | sort | uniq -c

#===Xem trọng số hiện tại của listener production===
ALB_ARN=$(aws elbv2 describe-load-balancers --names bluegreen-lab-alb --region ap-southeast-1 --query 'LoadBalancers[0].LoadBalancerArn' --output text)
aws elbv2 describe-listeners --load-balancer-arn $ALB_ARN --region ap-southeast-1 --query 'Listeners[].{port:Port,targetGroups:DefaultActions[0].ForwardConfig.TargetGroups}'

#===(Tuỳ chọn) Số request Target Group blue nhận được trong 15 phút gần nhất (CloudWatch metric của ALB)===
# Đổi bluegreen-lab-tg-blue thành bluegreen-lab-tg-green để xem Target Group còn lại,
# đổi RequestCount thành HTTPCode_Target_5XX_Count để xem số lỗi 5xx.
ALB_DIM=$(echo $ALB_ARN | cut -d'/' -f2-)
TG_BLUE_DIM=$(aws elbv2 describe-target-groups --names bluegreen-lab-tg-blue --region ap-southeast-1 --query 'TargetGroups[0].TargetGroupArn' --output text | cut -d':' -f6)
aws cloudwatch get-metric-statistics --namespace AWS/ApplicationELB --metric-name RequestCount --dimensions Name=LoadBalancer,Value=$ALB_DIM Name=TargetGroup,Value=$TG_BLUE_DIM --start-time $(date -u -d '-15 minutes' +%Y-%m-%dT%H:%M:%SZ) --end-time $(date -u +%Y-%m-%dT%H:%M:%SZ) --period 300 --statistics Sum --region ap-southeast-1
