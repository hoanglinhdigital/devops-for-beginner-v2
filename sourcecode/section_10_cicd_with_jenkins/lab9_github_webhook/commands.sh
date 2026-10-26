#!/bin/bash
# Lab 9 – Tự động trigger job Jenkins từ GitHub webhook
# Tập hợp lệnh tham khảo, chạy trên máy local (Git Bash / Terminal) trong repository nodejs-random-color.

#===Bước 1: Tạo nhánh develop từ master, thêm Jenkinsfile-auto rồi push===
cd ~/jenkins-labs/nodejs-random-color
git checkout master
git pull origin master
git checkout -b develop
git add Jenkinsfile-auto
git commit -m "ci: add Jenkinsfile-auto for develop CI/CD"
git push -u origin develop

#===Bước 2: (Tham khảo) Lấy dải IP webhook của GitHub để giới hạn Security Group===
curl -s https://api.github.com/meta | jq '.hooks'

#===Bước 3: Kiểm tra endpoint webhook của Jenkins từ máy local (kết quả mong đợi: HTTP 405 hoặc 200, không phải timeout)===
curl -s -o /dev/null -w "%{http_code}\n" http://<jenkins-public-ip>:8080/github-webhook/

#===Bước 7: Sửa code & push lên develop để trigger CI/CD===
git add public/index.html
git commit -m "feat: update welcome message v3 from develop"
git push origin develop

#===Bước 8: Kiểm tra version mới qua ALB (thay <alb-dns-name>)===
curl -s http://<alb-dns-name>/ | grep -o "<h1[^>]*>[^<]*"
