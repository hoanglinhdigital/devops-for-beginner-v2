#!/bin/bash
# Lab 6 - Quản lý Service với systemctl
# Copy từng lệnh và chạy theo hướng dẫn trong bài lab, không chạy cả file.

########## Phần 1: Cài đặt web server httpd (Apache) ##########
sudo dnf update -y
sudo dnf install -y httpd
systemctl status httpd

# Tạo trang web đơn giản: copy nội dung file index.html trong source code
sudo vim /var/www/html/index.html

########## Phần 2: Start / Status / Stop / Restart ##########
sudo systemctl start httpd
systemctl status httpd
curl http://localhost
# Truy cập http://<PUBLIC_IP> trên trình duyệt

sudo systemctl stop httpd
systemctl status httpd
curl http://localhost

sudo systemctl start httpd
sudo systemctl restart httpd
sudo systemctl reload httpd

########## Phần 3: Enable service khởi động cùng OS ##########
systemctl is-enabled httpd
sudo systemctl enable httpd
systemctl is-enabled httpd
sudo reboot
# Đợi 1-2 phút, SSH lại vào server
systemctl is-active httpd
curl http://localhost

########## Phần 4: Xem log của service ##########
sudo journalctl -u httpd --no-pager | tail -20
sudo tail -f /var/log/httpd/access_log
# Refresh trình duyệt vài lần để thấy log, nhấn Ctrl + C để thoát

########## Phần 5: Liệt kê service ##########
systemctl list-units --type=service --state=running
systemctl list-unit-files --type=service | grep enabled

########## Phần 6: Tự tạo một service (systemd unit) ##########
# Copy nội dung file hello.sh trong source code
sudo vim /usr/local/bin/hello.sh
sudo chmod 755 /usr/local/bin/hello.sh

# Copy nội dung file hello.service trong source code
sudo vim /etc/systemd/system/hello.service

sudo systemctl daemon-reload
sudo systemctl enable --now hello
systemctl status hello
sudo journalctl -u hello -f
# Nhấn Ctrl + C để thoát

# Thử kill process, systemd sẽ tự khởi động lại (Restart=always)
systemctl show -p MainPID hello
sudo kill -9 $(systemctl show -p MainPID --value hello)
sleep 6
systemctl status hello

########## Dọn dẹp ##########
sudo systemctl disable --now hello
sudo rm /etc/systemd/system/hello.service /usr/local/bin/hello.sh
sudo systemctl daemon-reload
# Giữ httpd nếu muốn, hoặc gỡ bỏ:
sudo systemctl disable --now httpd
sudo dnf remove -y httpd
