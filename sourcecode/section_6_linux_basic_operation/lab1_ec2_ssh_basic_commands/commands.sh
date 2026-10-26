#!/bin/bash
# Lab 1 - Tạo EC2 Linux, kết nối SSH & các lệnh cơ bản
# Copy từng lệnh và chạy theo hướng dẫn trong bài lab, không chạy cả file.

########## Trên PC Local (Git Bash / Terminal) ##########
# Di chuyển tới thư mục chứa file key đã tải về từ AWS Console
cd ~/Downloads

# Giới hạn quyền file private key (bắt buộc trên Mac/Linux, ssh sẽ từ chối key có quyền quá rộng)
chmod 400 linux-lab-key.pem

# SSH vào EC2 (thay <PUBLIC_IP> bằng Public IPv4 address của instance)
ssh -i linux-lab-key.pem ec2-user@<PUBLIC_IP>

########## Trên EC2 instance ##########
# Thông tin hệ thống
hostname
whoami
id
date
uptime
uname -r
cat /etc/os-release

# Thư mục làm việc & di chuyển
pwd
cd /etc
pwd
cd ~
cd ..
pwd
cd -

# Liệt kê file/folder
ls
ls -l
ls -la
ls -lh /var/log

# Danh sách user trên hệ thống (sắp xếp theo tên)
cat /etc/passwd | sort

# Tạo, copy, đổi tên, xoá file/folder
cd ~
mkdir linux-lab
cd linux-lab
touch hello.txt
echo "Hello Linux from EC2" > hello.txt
echo "Dòng thứ 2" >> hello.txt
cat hello.txt
cp hello.txt hello-copy.txt
mv hello-copy.txt hello-backup.txt
mkdir -p demo/sub1/sub2
ls -R demo
rm hello-backup.txt
rm -r demo
ls -l

# Tra cứu cách dùng lệnh
ls --help
man ls

# Lịch sử lệnh, xoá màn hình, thoát
history
clear
exit
