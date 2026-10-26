#!/bin/bash
# Lab 2 – Job Deploy lên môi trường idle (Green) & kiểm thử qua test listener :81
# Tập hợp lệnh tham khảo, chạy trên máy local (Git Bash / Terminal).

#===Bước 2: Sửa code & tạo tag v2.1.0 (trong repository nodejs-random-color)===
cd ~/jenkins-labs/nodejs-random-color
# Sửa text thẻ <h1 id="welcome" ...> trong public/index.html thành: Welcome to My Website – v2.1.0
git add public/index.html
git commit -m "feat: release v2.1.0"
git push origin master
git tag -a v2.1.0 -m "Release v2.1.0"
git push origin v2.1.0

#===Bước 5: So sánh production (:80) và test (:81) – thay <alb-dns-name>===
curl -s http://<alb-dns-name>/ | grep -o "<h1[^>]*>[^<]*"
curl -s http://<alb-dns-name>:81/ | grep -o "<h1[^>]*>[^<]*"

#===Kiểm tra revision đang chạy trên từng cluster===
aws ecs describe-services --cluster bluegreen-lab-cluster-blue --services nodejs-service --region ap-southeast-1 --query 'services[0].{taskDef:taskDefinition,desired:desiredCount,running:runningCount}'
aws ecs describe-services --cluster bluegreen-lab-cluster-green --services nodejs-service --region ap-southeast-1 --query 'services[0].{taskDef:taskDefinition,desired:desiredCount,running:runningCount}'

#===Kiểm tra image của một revision (thay <revision>)===
aws ecs describe-task-definition --task-definition bluegreen-lab-nodejs-task:<revision> --region ap-southeast-1 --query 'taskDefinition.containerDefinitions[0].image'
