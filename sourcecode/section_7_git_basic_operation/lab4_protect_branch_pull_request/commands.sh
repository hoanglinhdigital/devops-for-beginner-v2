#!/bin/bash
# Lab 4 - Protect branch, tạo nhánh feature & Pull Request
# Copy từng lệnh và chạy theo hướng dẫn trong bài lab, không chạy cả file.

########## Bước 1: Tạo Ruleset bảo vệ main & develop (thao tác trên GitHub) ##########
# Repository demo-git -> Settings -> Rules -> Rulesets -> New branch ruleset
#   Ruleset name: protect-main-develop
#   Enforcement status: Active
#   Bypass list: để trống
#   Target branches: Include default branch + Include by pattern "develop"
#   Rules: Restrict deletions, Require a pull request before merging (Required approvals: 0), Block force pushes

########## Bước 2: Kiểm tra - push trực tiếp vào develop sẽ bị chặn ##########
cd ~/git-labs/demo-git
git checkout develop
git pull origin develop
git commit --allow-empty -m "test: direct push to develop"
git push origin develop
# Kết quả mong đợi: ! [remote rejected] develop -> develop (push declined due to repository rule violations)
# Bỏ commit test vừa tạo, đưa develop local về giống develop trên GitHub:
git reset --hard origin/develop
git log --oneline -3

########## Bước 3: Tạo nhánh feature/F001 từ develop ##########
git checkout develop
git pull origin develop
git checkout -b feature/F001

########## Bước 4: Thay đổi code ##########
# Copy file about.html (thư mục lab4_protect_branch_pull_request) vào repository
# Sửa index.html: thêm <li><a href="about.html">About</a></li>
git status
git add about.html index.html
git commit -m "feat(F001): add about page"

########## Bước 5: Push nhánh feature/F001 ##########
git push -u origin feature/F001

########## Bước 6: Tạo Pull Request trên GitHub ##########
# base: develop  <-  compare: feature/F001
# Title: F001 - Add about page | Description: mô tả thay đổi, cách test

########## Bước 7: Review, Approve & Merge Pull Request ##########
# Tab "Files changed" -> comment/Review changes -> Merge pull request (Create a merge commit) -> Delete branch

########## Bước 8: Cập nhật develop local sau khi merge ##########
git checkout develop
git pull origin develop
git log --oneline --graph -10
git branch -d feature/F001
git fetch --prune
git branch -a
