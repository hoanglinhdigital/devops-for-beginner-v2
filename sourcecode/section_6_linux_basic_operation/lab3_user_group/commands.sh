#!/bin/bash
# Lab 3 - Quản lý User, Group & quyền sudo
# Copy từng lệnh và chạy theo hướng dẫn trong bài lab, không chạy cả file.

########## Phần 1: Cho phép login bằng username/password ##########
# (Login bằng ec2-user) Kiểm tra cấu hình hiện tại
sudo grep -ri "PasswordAuthentication" /etc/ssh/sshd_config /etc/ssh/sshd_config.d/

# Tạo file cấu hình bổ sung (file có số nhỏ được đọc trước, giá trị đọc trước được ưu tiên)
sudo vim /etc/ssh/sshd_config.d/01-password-auth.conf
# Nội dung file (1 dòng):
# PasswordAuthentication yes

# Kiểm tra cú pháp & giá trị có hiệu lực, sau đó restart SSH service
sudo sshd -t
sudo sshd -T | grep -i passwordauthentication
sudo systemctl restart sshd

########## Phần 2: Tạo user & đặt password ##########
sudo useradd developer1
sudo passwd developer1
id developer1
grep developer1 /etc/passwd
ls -ld /home/developer1

# Logout, login lại bằng developer1 từ PC Local (nhập password vừa đặt)
exit
ssh developer1@<PUBLIC_IP>
whoami
pwd
# Thử sudo -> báo lỗi "developer1 is not in the sudoers file"
sudo whoami
exit

########## Phần 3: Tạo group & cấp quyền sudo cho group ##########
# Login lại bằng ec2-user
ssh -i linux-lab-key.pem ec2-user@<PUBLIC_IP>

sudo groupadd developer_group
sudo usermod -a -G developer_group developer1
id developer1
grep developer_group /etc/group

# Cấp quyền sudo cho group: tạo file riêng trong /etc/sudoers.d bằng visudo (có kiểm tra cú pháp)
sudo visudo -f /etc/sudoers.d/developer_group
# Nội dung file (1 dòng):
# %developer_group ALL=(ALL) ALL

sudo visudo -c

# Login lại bằng developer1 và thử sudo
exit
ssh developer1@<PUBLIC_IP>
sudo whoami
sudo su -
whoami
exit
exit

########## Phần 4: Một số lệnh quản lý user/group khác ##########
# (Login bằng ec2-user)
sudo usermod -c "Developer 1 - Team A" developer1
getent passwd developer1
sudo groupmod -n dev_team developer_group
getent group dev_team
sudo groupmod -n developer_group dev_team
groups developer1

########## Phần 5: Tắt lại login bằng password (bảo mật) ##########
sudo rm /etc/ssh/sshd_config.d/01-password-auth.conf
sudo systemctl restart sshd
sudo sshd -T | grep -i passwordauthentication

# User developer1 & developer_group được giữ lại cho Lab 4.
# Xoá khi không dùng nữa:
# sudo rm /etc/sudoers.d/developer_group
# sudo userdel -r developer1
# sudo groupdel developer_group
