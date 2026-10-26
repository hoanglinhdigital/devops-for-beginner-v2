#!/bin/bash
# Lab 9 - Thêm SSH key cho thành viên dự án
# Copy từng lệnh và chạy theo hướng dẫn trong bài lab, không chạy cả file.
# KHÔNG commit private key lên Git. Mỗi thành viên tự sinh key trên máy của mình.

########## Bước 1: (PC Local của thành viên dev01) Sinh cặp key ##########
mkdir -p ~/.ssh
ssh-keygen -t ed25519 -C "dev01" -f ~/.ssh/dev01
# Hoặc dùng RSA nếu hệ thống cũ không hỗ trợ ed25519:
# ssh-keygen -t rsa -b 4096 -C "dev01" -f ~/.ssh/dev01
ls -l ~/.ssh/dev01 ~/.ssh/dev01.pub
cat ~/.ssh/dev01.pub

########## Bước 2: (Server, login bằng ec2-user) Tạo user dev01 ##########
sudo useradd dev01
id dev01

########## Bước 3: Cấu hình authorized_keys cho dev01 ##########
sudo su - dev01
pwd
whoami
mkdir -p ~/.ssh
chmod 700 ~/.ssh
vim ~/.ssh/authorized_keys
# Dán nội dung file dev01.pub (1 dòng, bắt đầu bằng ssh-ed25519 ...), lưu và thoát
chmod 600 ~/.ssh/authorized_keys
ls -la ~/.ssh
exit

########## Bước 4: (PC Local) Login bằng private key của dev01 ##########
ssh -i ~/.ssh/dev01 dev01@<PUBLIC_IP>
whoami
exit

########## Bước 5 (tuỳ chọn): Cấu hình ~/.ssh/config để SSH nhanh ##########
# Thêm vào file ~/.ssh/config trên PC Local:
# Host linux-lab-dev01
#     HostName <PUBLIC_IP>
#     User dev01
#     IdentityFile ~/.ssh/dev01
ssh linux-lab-dev01

########## Bước 6: Thu hồi quyền truy cập khi thành viên rời dự án ##########
# (Server, login bằng ec2-user)
sudo userdel -r dev01
id dev01
