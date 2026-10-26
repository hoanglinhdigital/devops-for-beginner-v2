#!/bin/bash
# Lab 1 – Chuẩn bị source code trên GitHub & tạo kết nối GitHub (AWS CodeConnections)
# Tập hợp lệnh tham khảo, copy từng lệnh và chạy trong Git Bash / Terminal.

#===Bước 1: Fork 3 repository mẫu về GitHub account của bạn (thao tác trên GitHub)===
# https://github.com/hoanglinhdigital/java-elasticbeanstalk-sample   (branch: main)
# https://github.com/hoanglinhdigital/simple-vue-webpack             (branch: master)
# https://github.com/hoanglinhdigital/nodejs-random-color            (branch: master)

#===Bước 2: Clone 3 repository đã fork về máy (thay <your-github-username>)===
mkdir -p ~/codepipeline-labs
cd ~/codepipeline-labs
git clone git@github.com:<your-github-username>/java-elasticbeanstalk-sample.git
git clone git@github.com:<your-github-username>/simple-vue-webpack.git
git clone git@github.com:<your-github-username>/nodejs-random-color.git
ls

#===Bước 3: Kiểm tra branch mặc định của từng repository===
git -C java-elasticbeanstalk-sample branch --show-current
git -C simple-vue-webpack branch --show-current
git -C nodejs-random-color branch --show-current

#===Bước 4: Tạo S3 bucket chứa artifact (tên bucket là duy nhất toàn cầu, thay <your-suffix>)===
aws s3 mb s3://codebuild-artifact-<your-suffix> --region ap-southeast-1
aws s3 ls
