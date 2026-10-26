#!/bin/bash
# Lab 4 - Phân quyền & thay đổi owner của File/Folder
# Copy từng lệnh và chạy theo hướng dẫn trong bài lab, không chạy cả file.
# Yêu cầu: đã có user developer1 và group developer_group từ Lab 3.

########## Bước 1: Đọc kết quả ls -l ##########
cd /etc
ls -l
ls -ld /etc/ssh
ls -l /etc/passwd /etc/shadow

########## Bước 2: Tạo folder & file với user ec2-user ##########
cd /home/ec2-user
mkdir test_folder
cd test_folder
vim test_file.txt
# Nhập 1 dòng nội dung bất kỳ, lưu và thoát (Esc, :wq, Enter)
ls -l
ls -ld /home/ec2-user /home/ec2-user/test_folder

########## Bước 3: chmod dạng số ##########
chmod 750 test_file.txt
ls -l test_file.txt

########## Bước 4: developer1 thử đọc file -> Permission denied ##########
sudo su - developer1
cat /home/ec2-user/test_folder/test_file.txt
ls /home/ec2-user
exit

########## Bước 5: Mở quyền "đi qua" thư mục cho other ##########
chmod 711 /home/ec2-user
chmod 755 /home/ec2-user/test_folder
ls -ld /home/ec2-user /home/ec2-user/test_folder

sudo su - developer1
ls -l /home/ec2-user/test_folder
cat /home/ec2-user/test_folder/test_file.txt
exit

########## Bước 6: chown/chgrp - đổi group sở hữu của file ##########
sudo chown ec2-user:developer_group /home/ec2-user/test_folder/test_file.txt
ls -l /home/ec2-user/test_folder/test_file.txt

sudo su - developer1
cat /home/ec2-user/test_folder/test_file.txt
echo "developer1 was here" >> /home/ec2-user/test_folder/test_file.txt
exit

########## Bước 7: chmod dạng ký hiệu (symbolic) ##########
chmod g+w /home/ec2-user/test_folder/test_file.txt
ls -l /home/ec2-user/test_folder/test_file.txt

sudo su - developer1
echo "developer1 was here" >> /home/ec2-user/test_folder/test_file.txt
cat /home/ec2-user/test_folder/test_file.txt
exit

chmod o-x /home/ec2-user/test_folder
chmod u=rwx,g=rx,o= /home/ec2-user/test_folder
ls -ld /home/ec2-user/test_folder

########## Bước 8: Thư mục dùng chung cho team với chown -R ##########
sudo mkdir -p /opt/project/src
sudo touch /opt/project/README.md /opt/project/src/app.py
ls -lR /opt/project
sudo chown -R developer1:developer_group /opt/project
sudo chmod -R g+w /opt/project
ls -lR /opt/project

sudo su - developer1
echo "print('hello')" >> /opt/project/src/app.py
cat /opt/project/src/app.py
exit

########## Dọn dẹp ##########
chmod 700 /home/ec2-user
rm -rf /home/ec2-user/test_folder
sudo rm -rf /opt/project
sudo rm -f /etc/sudoers.d/developer_group
sudo userdel -r developer1
sudo groupdel developer_group
