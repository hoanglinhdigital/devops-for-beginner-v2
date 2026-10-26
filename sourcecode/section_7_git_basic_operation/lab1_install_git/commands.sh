#!/bin/bash
# Lab 1 - Cài đặt Git, SourceTree & clone repository đầu tiên
# Copy từng lệnh và chạy theo hướng dẫn trong bài lab, không chạy cả file.

########## Bước 1: Cài đặt Git ##########
# Windows: tải Git for Windows tại https://git-scm.com/downloads (giữ các tuỳ chọn mặc định)
# Mac:     brew install git   (hoặc xcode-select --install)
# Ubuntu:  sudo apt install -y git
# Amazon Linux 2023: sudo dnf install -y git
git --version

########## Bước 2: Cấu hình thông tin người dùng (chỉ làm 1 lần) ##########
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global core.autocrlf true      # Windows
# git config --global core.autocrlf input   # Mac/Linux
git config --global core.editor "code --wait"
git config --global --list

########## Bước 3: Tạo thư mục làm việc ##########
mkdir -p ~/git-labs
cd ~/git-labs
pwd

########## Bước 4: Clone một public repository ##########
git clone https://github.com/octocat/Hello-World.git
cd Hello-World
ls -la
git status
git log --oneline
git branch
git branch -a

########## Bước 5: Mở repository bằng VS Code ##########
code .

########## Bước 6: SourceTree ##########
# Tải SourceTree: https://www.sourcetreeapp.com/
# File -> Open -> chọn thư mục ~/git-labs/Hello-World -> xem tab History, Branches, Remotes
