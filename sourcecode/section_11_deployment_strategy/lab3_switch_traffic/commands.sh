#!/bin/bash
# Lab 3 – Switch traffic Blue/Green & rollback
# Tập hợp lệnh tham khảo, chạy trên máy local (Git Bash / Terminal).

#===Bước 2: Mở 1 cửa sổ Terminal, gửi request liên tục tới production trong lúc switch (thay <alb-dns-name>, Ctrl + C để dừng)===
while true; do echo "$(date +%T) $(curl -s -o /dev/null -w '%{http_code}' http://<alb-dns-name>/) $(curl -s http://<alb-dns-name>/ | grep -o '<h1[^>]*>[^<]*' | grep -o 'v[0-9.]*')"; sleep 1; done

#===Bước 4: Kiểm tra trạng thái listener sau khi switch===
ALB_ARN=$(aws elbv2 describe-load-balancers --names bluegreen-lab-alb --region ap-southeast-1 --query 'LoadBalancers[0].LoadBalancerArn' --output text)
aws elbv2 describe-listeners --load-balancer-arn $ALB_ARN --region ap-southeast-1 --query 'Listeners[].{port:Port,targetGroups:DefaultActions[0].ForwardConfig.TargetGroups}'

#===Xem tên Target Group từ ARN===
aws elbv2 describe-target-groups --names bluegreen-lab-tg-blue bluegreen-lab-tg-green --region ap-southeast-1 --query 'TargetGroups[].{name:TargetGroupName,arn:TargetGroupArn}' --output table

#===Kiểm tra version trên 2 listener===
curl -s http://<alb-dns-name>/ | grep -o "<h1[^>]*>[^<]*"
curl -s http://<alb-dns-name>:81/ | grep -o "<h1[^>]*>[^<]*"
