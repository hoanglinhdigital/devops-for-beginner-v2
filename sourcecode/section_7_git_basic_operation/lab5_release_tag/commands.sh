#!/bin/bash
# Lab 5 - Tạo nhánh release, merge vào main & đánh tag
# Copy từng lệnh và chạy theo hướng dẫn trong bài lab, không chạy cả file.

########## Bước 1: Tạo nhánh release/v0.1 từ develop ##########
cd ~/git-labs/demo-git
git checkout develop
git pull origin develop
git checkout -b release/v0.1

########## Bước 2: Chỉnh sửa nhỏ trước release (cập nhật version) ##########
# Copy file VERSION (thư mục lab5_release_tag) vào repository, nội dung: 0.1.0
git add VERSION
git commit -m "chore(release): bump version to 0.1.0"
git push -u origin release/v0.1

########## Bước 3: Pull Request release/v0.1 -> main (thao tác trên GitHub) ##########
# base: main  <-  compare: release/v0.1  -> Create pull request -> Merge pull request
# KHÔNG xoá nhánh release/v0.1 ngay, còn dùng ở Bước 5

########## Bước 4: Đánh tag v0.1 trên main ##########
git checkout main
git pull origin main
git log --oneline -5
git tag -a v0.1 -m "Release version 0.1"
git tag
git show v0.1
git push origin v0.1
# Push tất cả tag (nếu có nhiều tag): git push origin --tags

########## Bước 5: Merge release/v0.1 ngược lại develop ##########
# GitHub: Pull Request base: develop <- compare: release/v0.1 -> Merge -> Delete branch
git checkout develop
git pull origin develop
cat VERSION

########## Bước 6 (tuỳ chọn): Tạo GitHub Release từ tag ##########
# Repository -> Releases -> Draft a new release -> Choose a tag: v0.1 -> Generate release notes -> Publish release

########## Tham khảo: xoá tag khi đánh nhầm ##########
# git tag -d v0.1
# git push origin --delete v0.1
