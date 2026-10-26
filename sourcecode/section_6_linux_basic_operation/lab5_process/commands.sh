#!/bin/bash
# Lab 5 - Quản lý Process
# Copy từng lệnh và chạy theo hướng dẫn trong bài lab, không chạy cả file.

########## Bước 1: Liệt kê process ##########
ps                # process của user hiện tại trong terminal hiện tại
ps -e             # tất cả process, không quan tâm owner
ps -ef            # tất cả process, format đầy đủ (UID, PID, PPID, CMD)
ps aux            # tương tự ps -ef, thêm %CPU, %MEM, STAT, thời gian start
ps -l             # format dài (có cột trạng thái S)
ps -ef | head -5  # PID 1 là systemd - process cha của mọi process

########## Bước 2: Theo dõi process real-time với top ##########
top
# Trong top: P (sắp xếp theo CPU), M (theo RAM), 1 (từng CPU), q (thoát)

########## Bước 3: Chạy process ở background ##########
sleep 1000 &
sleep 2000 &
jobs
ps -ef | grep sleep
pgrep -a sleep

########## Bước 4: Foreground / Background ##########
sleep 3000
# Nhấn Ctrl + Z để tạm dừng (Stopped), sau đó:
jobs
bg %3
jobs
fg %3
# Nhấn Ctrl + C để dừng hẳn process đang chạy foreground

########## Bước 5: Kết thúc process bằng kill ##########
pgrep -a sleep
kill <PID_sleep_1000>        # gửi SIGTERM (15) - yêu cầu dừng "lịch sự"
kill -9 <PID_sleep_2000>     # gửi SIGKILL (9)  - buộc dừng ngay lập tức
pgrep -a sleep

# Kill theo tên process
sleep 4000 &
sleep 5000 &
pkill sleep
pgrep -a sleep

########## Bước 6: Process của user khác ##########
ps -u root | head
ps -u ec2-user
# User thường không kill được process của user khác -> "Operation not permitted"
kill $(pgrep -o sshd)

########## Bước 7: Tài nguyên hệ thống ##########
free -h
nproc
uptime
