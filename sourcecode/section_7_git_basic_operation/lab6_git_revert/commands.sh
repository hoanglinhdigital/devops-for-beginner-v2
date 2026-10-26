#!/bin/bash
# Lab 6 - Git log, show & revert
# Copy từng lệnh và chạy theo hướng dẫn trong bài lab, không chạy cả file.

########## Bước 1: Tạo nhánh feature/F002 từ develop ##########
cd ~/git-labs/demo-git
git checkout develop
git pull origin develop
git checkout -b feature/F002

########## Bước 2: Tạo 2 commit ##########
# Sửa index.html: thêm <li>Lab 6: Git revert</li>
git add index.html
git commit -m "feat(F002): add lab 6 item"

# Sửa index.html: thêm <p class="banner">SALE 90%!!!</p> (giả lập thay đổi lỗi)
git add index.html
git commit -m "feat(F002): add sale banner"
git push -u origin feature/F002

########## Bước 3: Xem lịch sử commit ##########
git log
git log --oneline
git log --oneline --graph --all -15
git log --oneline -- index.html
git log --author="Your Name" --oneline

########## Bước 4: Xem chi tiết 1 commit ##########
# Thay <COMMIT_HASH> bằng hash của commit "add sale banner"
git show <COMMIT_HASH>
git show --stat <COMMIT_HASH>
git show HEAD

########## Bước 5: Revert commit lỗi ##########
git revert <COMMIT_HASH>
# Git mở editor để sửa message (mặc định "Revert ..."), lưu và đóng để hoàn tất
# Hoặc bỏ qua editor: git revert --no-edit <COMMIT_HASH>
git log --oneline -5
cat index.html
git push

########## Bước 6: Revert lại commit revert (khôi phục thay đổi) ##########
# Thay <REVERT_COMMIT_HASH> bằng hash của commit "Revert ..."
git revert --no-edit <REVERT_COMMIT_HASH>
git log --oneline -5
cat index.html
# Revert thêm 1 lần để giữ trạng thái không có banner cho các lab sau
git revert --no-edit HEAD
git push

########## Bước 7: Tạo Pull Request feature/F002 -> develop và merge ##########
git checkout develop
git pull origin develop
git branch -d feature/F002
