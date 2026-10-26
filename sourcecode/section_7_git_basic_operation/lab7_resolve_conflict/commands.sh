#!/bin/bash
# Lab 7 - Giả lập & xử lý conflict trên Git
# Copy từng lệnh và chạy theo hướng dẫn trong bài lab, không chạy cả file.
# Dev A làm việc tại ~/git-labs/demo-git, Dev B làm việc tại bản clone thứ 2 ~/git-labs/demo-git-devB

########## Bước 1: Chuẩn bị file test.txt trên develop ##########
cd ~/git-labs/demo-git
git checkout develop
git pull origin develop
git checkout -b feature/add-test-file
# Copy file test.txt (thư mục lab7_resolve_conflict) vào repository
git add test.txt
git commit -m "chore: add test.txt for conflict lab"
git push -u origin feature/add-test-file
# GitHub: tạo PR feature/add-test-file -> develop và Merge

########## Bước 2: Dev A tạo nhánh feature/devA và sửa test.txt ##########
cd ~/git-labs/demo-git
git checkout develop
git pull origin develop
git checkout -b feature/devA
# Sửa dòng 3 của test.txt thành: Trạng thái: Hoàn thành (Dev A)
git add test.txt
git commit -m "feat(devA): update status in test.txt"
git push -u origin feature/devA
# CHƯA tạo Pull Request

########## Bước 3: Dev B clone repository, tạo nhánh feature/devB, sửa cùng dòng ##########
cd ~/git-labs
git clone git@github.com:<GITHUB_USERNAME>/demo-git.git demo-git-devB
cd ~/git-labs/demo-git-devB
git checkout develop
git checkout -b feature/devB
# Sửa dòng 3 của test.txt thành: Trạng thái: Đang kiểm thử (Dev B)
git add test.txt
git commit -m "feat(devB): update status in test.txt"
git push -u origin feature/devB
# GitHub: tạo PR feature/devB -> develop và Merge (không conflict vì là người merge trước)

########## Bước 4: Dev A tạo Pull Request -> bị conflict ##########
# GitHub: tạo PR feature/devA -> develop
# Thông báo: "This branch has conflicts that must be resolved"

########## Bước 5: Dev A resolve conflict ở local ##########
cd ~/git-labs/demo-git
git checkout feature/devA
git pull origin develop
# Kết quả: CONFLICT (content): Merge conflict in test.txt
git status
code test.txt
# Chọn Accept Current / Accept Incoming / Accept Both hoặc sửa tay, xoá hết các dấu <<<<<<< ======= >>>>>>>
# Ví dụ nội dung sau khi thống nhất với Dev B: Trạng thái: Hoàn thành (Dev A), đã kiểm thử (Dev B)
git add test.txt
git commit -m "merge: resolve conflict with develop in test.txt"
git log --oneline --graph -8
git push

########## Bước 6: Merge Pull Request của Dev A ##########
# GitHub: PR feature/devA -> develop giờ đã "No conflicts" -> Merge -> Delete branch
git checkout develop
git pull origin develop
cat test.txt

########## Tham khảo: huỷ merge khi đang conflict (quay về trạng thái trước khi pull) ##########
# git merge --abort
