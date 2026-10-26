#!/bin/bash
# Lab 8 - Lập lịch tác vụ với Cron job
# Copy từng lệnh và chạy theo hướng dẫn trong bài lab, không chạy cả file.

########## Bước 1: Cài đặt cron (Amazon Linux 2023 không cài sẵn) ##########
sudo dnf install -y cronie
sudo systemctl enable --now crond
systemctl status crond

########## Bước 2: Tạo script ##########
# Copy nội dung file script.sh trong source code
vim /home/ec2-user/script.sh
chmod 755 /home/ec2-user/script.sh
/home/ec2-user/script.sh
cat /home/ec2-user/log.txt

########## Bước 3: Cách 1 - crontab của user (crontab -e) ##########
crontab -l
crontab -e
# Thêm dòng sau (KHÔNG có cột user), lưu và thoát:
# * * * * * /home/ec2-user/script.sh
crontab -l

# Đợi 2-3 phút rồi kiểm tra
cat /home/ec2-user/log.txt
tail -f /home/ec2-user/log.txt
# Nhấn Ctrl + C để thoát

# Xem log của cron daemon
sudo journalctl -u crond --since "10 minutes ago" --no-pager

########## Bước 4: Cách 2 - crontab hệ thống (/etc/crontab, CÓ cột user) ##########
cat /etc/crontab
sudo vim /etc/crontab
# Thêm dòng sau (chạy mỗi 2 phút với user ec2-user):
# */2 * * * * ec2-user /home/ec2-user/script.sh

sudo crontab -l

########## Dọn dẹp ##########
crontab -r
crontab -l
sudo vim /etc/crontab
# Xoá dòng */2 * * * * ec2-user /home/ec2-user/script.sh đã thêm
rm /home/ec2-user/script.sh /home/ec2-user/log.txt
