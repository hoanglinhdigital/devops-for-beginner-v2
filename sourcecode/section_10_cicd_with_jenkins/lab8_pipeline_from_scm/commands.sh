#!/bin/bash
# Lab 8 – Pipeline from SCM & private repository (SSH Deploy key)
# Tập hợp lệnh tham khảo, chạy trên máy local (Git Bash / Terminal).

#===Bước 1: Tạo SSH key pair riêng cho Jenkins (không đặt passphrase)===
ssh-keygen -t ed25519 -C "jenkins-deploy-key" -f ~/.ssh/jenkins_github -N ""
ls -la ~/.ssh/jenkins_github*

#===Bước 2: Copy public key -> GitHub repository Settings -> Deploy keys (Read-only)===
cat ~/.ssh/jenkins_github.pub

#===Bước 4: Copy private key -> Jenkins credential "SSH Username with private key"===
cat ~/.ssh/jenkins_github

#===Bước 5: Copy Jenkinsfile của lab này vào thư mục gốc repository rồi push===
cd ~/jenkins-labs/nodejs-random-color
git add Jenkinsfile
git commit -m "ci: add Jenkinsfile for pipeline from SCM"
git push origin master

#===Kiểm tra trên Jenkins server: kết nối SSH tới GitHub với user jenkins (tuỳ chọn)===
sudo -u jenkins ssh -T git@github.com
