#!/bin/bash
# Lab 2 - Tạo repository trên GitHub & cấu hình SSH key
# Copy từng lệnh và chạy theo hướng dẫn trong bài lab, không chạy cả file.
# Tham khảo: https://docs.github.com/en/authentication/connecting-to-github-with-ssh

########## Bước 1: Tạo repository trên GitHub (thao tác trên giao diện web) ##########
# Repository name: demo-git
# Visibility: Public (để dùng được branch protection ở Lab 4 với tài khoản Free)
# Add a README file: bật
# Add .gitignore: None | License: None

########## Bước 2: Sinh SSH key trên PC Local (Git Bash) ##########
ls -la ~/.ssh
ssh-keygen -t ed25519 -C "your_email@example.com"
# Enter để lưu ở vị trí mặc định ~/.ssh/id_ed25519
# Enter 2 lần để bỏ qua passphrase (hoặc đặt passphrase, xem Bước 3)
ls -l ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub

########## Bước 3 (chỉ khi đặt passphrase): Thêm private key vào ssh-agent ##########
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
ssh-add -l

# Hoặc dùng ssh-agent service của Windows (PowerShell - Run as administrator):
# Get-Service -Name ssh-agent | Set-Service -StartupType Manual
# Start-Service ssh-agent
# ssh-add "$env:USERPROFILE\.ssh\id_ed25519"
# ssh-add -L

########## Bước 4: Copy public key và thêm vào GitHub ##########
cat ~/.ssh/id_ed25519.pub
# Windows Git Bash có thể copy thẳng vào clipboard:
clip < ~/.ssh/id_ed25519.pub
# GitHub: Settings -> SSH and GPG keys -> New SSH key
#   Title: laptop-<ten-may> | Key type: Authentication Key | Key: dán nội dung id_ed25519.pub

########## Bước 5: Kiểm tra kết nối SSH tới GitHub ##########
ssh -T git@github.com
# Lần đầu gõ "yes" để chấp nhận fingerprint của GitHub
# Kết quả mong đợi: Hi <GITHUB_USERNAME>! You've successfully authenticated, but GitHub does not provide shell access.

########## Bước 6: Clone repository bằng SSH ##########
cd ~/git-labs
git clone git@github.com:<GITHUB_USERNAME>/demo-git.git
cd demo-git
git remote -v
git branch -a
