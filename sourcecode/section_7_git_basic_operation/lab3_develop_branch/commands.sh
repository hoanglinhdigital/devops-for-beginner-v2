#!/bin/bash
# Lab 3 - Tạo nhánh develop, commit & push
# Copy từng lệnh và chạy theo hướng dẫn trong bài lab, không chạy cả file.

########## Bước 1: Đứng tại repository demo-git, cập nhật code mới nhất ##########
cd ~/git-labs/demo-git
git checkout main
git pull origin main

########## Bước 2: Tạo nhánh develop từ main ##########
git checkout -b develop
# Cách viết mới tương đương: git switch -c develop
git branch

########## Bước 3: Tạo/sửa file ##########
# Copy nội dung index.html, README.md, .gitignore (thư mục lab3_develop_branch) vào repository demo-git
code .
git status

########## Bước 4: Xem thay đổi & add vào staging area ##########
git diff README.md
git add index.html README.md .gitignore
# Hoặc add toàn bộ thay đổi: git add .
git status

########## Bước 5: Commit ##########
git commit -m "feat: add index.html, .gitignore and update README"
git log --oneline

########## Bước 6: Push nhánh develop lên GitHub ##########
git push -u origin develop
git branch -vv

########## Bước 7: Sửa thêm 1 lần, commit & push (không cần -u nữa) ##########
# Sửa index.html (ví dụ thêm 1 dòng <li>), sau đó:
git add index.html
git commit -m "docs: add section list to index page"
git push
git log --oneline --graph --all
