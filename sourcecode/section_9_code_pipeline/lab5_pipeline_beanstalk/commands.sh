#!/bin/bash
# Lab 5 – CodePipeline: GitHub → CodeBuild → Elastic Beanstalk
# Tập hợp lệnh tham khảo, copy từng lệnh và chạy trong Git Bash / Terminal.

cd ~/codepipeline-labs/java-elasticbeanstalk-sample

#===Sửa nội dung trả về trong file sau (đổi text, màu chữ...):===
# src/main/java/com/deploy/aws/demo/controller/HelloController.java
# Ví dụ: "Congratulations, your app has been deployed!" -> "Version 2 – deployed by CodePipeline!"

#===Commit & push để trigger pipeline===
git add .
git commit -m "feat: update greeting message v2"
git push origin main

#===Kiểm tra kết quả (thay <your-eb-domain> bằng domain của Elastic Beanstalk environment)===
curl http://<your-eb-domain>/
