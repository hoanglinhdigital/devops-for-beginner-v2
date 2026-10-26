#!/bin/bash
# Lab 8 – Canary deployment lên ECS với CodeDeploy
# Tập hợp lệnh tham khảo, copy từng lệnh và chạy trong Git Bash / Terminal.

#===Bước 1: Sửa public/index.html (đổi text thẻ <h1>), commit & push để trigger pipeline===
cd ~/codepipeline-labs/nodejs-random-color
git add public/index.html
git commit -m "feat: update welcome message v4 canary"
git push origin master

#===Bước 2: Gửi 20 request tới ALB và đếm số request trả về mỗi version (thay <alb-dns-name>)===
for i in $(seq 1 20); do curl -s http://<alb-dns-name>/ | grep -o "<h1[^>]*>[^<]*" | sed 's/<h1[^>]*>//'; done | sort | uniq -c
