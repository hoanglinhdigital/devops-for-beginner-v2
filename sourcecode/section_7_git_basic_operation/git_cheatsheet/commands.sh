#!/bin/bash
# Git cheatsheet - các lệnh thường dùng
# Tham khảo, không chạy cả file.

########## Cấu hình ##########
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"
git config --global --list

########## Khởi tạo & clone ##########
git init -b main
git clone git@github.com:<GITHUB_USERNAME>/<REPO>.git
git remote -v
git remote add origin git@github.com:<GITHUB_USERNAME>/<REPO>.git

########## Thay đổi & commit ##########
git status
git diff
git diff --staged
git add <file>
git add .
git restore <file>             # bỏ thay đổi chưa add của file
git restore --staged <file>    # bỏ file ra khỏi staging area
git commit -m "message"
git commit --amend -m "new message"   # sửa commit cuối (chưa push)

########## Branch ##########
git branch
git branch -a
git checkout -b <branch>       # = git switch -c <branch>
git checkout <branch>          # = git switch <branch>
git branch -d <branch>
git push origin --delete <branch>
git fetch --prune

########## Đồng bộ với remote ##########
git fetch origin
git pull origin <branch>
git push -u origin <branch>
git push

########## Merge / Rebase / Squash ##########
git merge <branch>
git merge --no-ff <branch>
git merge --squash <branch>
git rebase <branch>
git merge --abort
git rebase --abort

########## Lịch sử ##########
git log --oneline --graph --all
git log -p -- <file>
git show <commit>
git blame <file>
git reflog

########## Hoàn tác ##########
git revert <commit>
git reset --soft <commit>
git reset --mixed <commit>
git reset --hard <commit>

########## Stash ##########
git stash
git stash push --include-untracked -m "message"
git stash list
git stash pop
git stash apply
git stash drop

########## Tag ##########
git tag
git tag -a v1.0 -m "Release 1.0"
git push origin v1.0
git push origin --tags
git tag -d v1.0
git push origin --delete v1.0
