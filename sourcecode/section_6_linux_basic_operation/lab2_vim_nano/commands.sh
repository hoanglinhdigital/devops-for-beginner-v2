#!/bin/bash
# Lab 2 - Làm quen với trình soạn thảo Vim & Nano
# Copy từng lệnh và chạy theo hướng dẫn trong bài lab, không chạy cả file.

# Cài đặt Vim (bản đầy đủ) và Nano
sudo dnf install -y vim-enhanced nano
vim --version | head -1
nano --version | head -1

# Thư mục thực hành
mkdir -p ~/linux-lab/editor
cd ~/linux-lab/editor

########## Vim ##########
# Mở (tạo mới) file bằng Vim, dán nội dung file sample.txt vào
vim sample.txt
# Trong Vim:
#   i            -> vào Insert mode, dán nội dung
#   Esc          -> về Normal mode
#   :wq + Enter  -> lưu và thoát
#   :q!  + Enter -> thoát không lưu

# Kiểm tra nội dung đã lưu
cat sample.txt

# Mở lại file để thực hành các phím di chuyển, copy, paste, xoá, tìm kiếm
vim sample.txt
#   gg / G       -> đầu file / cuối file
#   yy, p        -> copy dòng hiện tại, paste xuống dưới
#   dd, u        -> xoá dòng, undo
#   /DevOps, n   -> tìm từ "DevOps", tới kết quả tiếp theo
#   :set number  -> hiện số dòng
#   :%s/Linux/LINUX/g -> thay thế toàn bộ "Linux" thành "LINUX"

########## Nano ##########
nano notes.txt
# Trong Nano:
#   Ctrl + O, Enter -> lưu file
#   Ctrl + X        -> thoát
#   Ctrl + W        -> tìm kiếm
#   Ctrl + K / Ctrl + U -> cắt dòng / dán dòng
cat notes.txt
