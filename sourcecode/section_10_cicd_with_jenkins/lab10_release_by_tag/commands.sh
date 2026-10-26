#!/bin/bash
# Lab 10 – Release production theo Git tag trên nhánh master
# Tập hợp lệnh tham khảo, chạy trên máy local (Git Bash / Terminal) trong repository nodejs-random-color.

#===Bước 2: Đưa code từ develop lên master (hoặc tạo Pull Request develop -> master trên GitHub)===
cd ~/jenkins-labs/nodejs-random-color
git checkout master
git pull origin master
git merge develop
git push origin master

#===Bước 3: Tạo annotated tag v1.0.0 trên master & push tag===
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
git tag -l

#===Bước 5: Release v1.0.1 – sửa code trên master, tạo tag mới===
git add public/index.html
git commit -m "feat: release v1.0.1"
git push origin master
git tag -a v1.0.1 -m "Release v1.0.1"
git push origin v1.0.1

#===Kiểm tra image tag trên ECR===
aws ecr list-images --repository-name nodejs-random-color --region ap-southeast-1 --query 'imageIds[].imageTag'

#===Kiểm tra version đang chạy trên ALB (thay <alb-dns-name>)===
curl -s http://<alb-dns-name>/ | grep -o "<h1[^>]*>[^<]*"

#===Xoá tag (khi cần làm lại)===
git tag -d v1.0.1
git push origin --delete v1.0.1
