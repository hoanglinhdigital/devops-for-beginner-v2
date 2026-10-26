#!/bin/bash
# Thực hành Merge / Rebase / Squash, stash, reset, reflog
# Làm trên repository LOCAL mới (git init), không cần GitHub.
# Copy từng lệnh và chạy theo hướng dẫn trong bài, không chạy cả file.

########## Chuẩn bị: tạo repository playground ##########
mkdir -p ~/git-labs/git-playground
cd ~/git-labs/git-playground
git init -b main
echo "line 1" > app.txt
git add app.txt
git commit -m "C1: init app"
echo "line 2" >> app.txt
git commit -am "C2: add line 2"

########## 1. Merge (tạo merge commit) ##########
git checkout -b feature/merge-demo
echo "merge feature" > merge.txt
git add merge.txt
git commit -m "M1: add merge.txt"
echo "merge feature 2" >> merge.txt
git commit -am "M2: update merge.txt"
git checkout main
echo "main change" > main.txt
git add main.txt
git commit -m "C3: add main.txt"
git merge --no-ff feature/merge-demo -m "Merge branch feature/merge-demo"
git log --oneline --graph --all

########## 2. Rebase (đưa commit của feature lên đầu main) ##########
git checkout -b feature/rebase-demo
echo "rebase feature" > rebase.txt
git add rebase.txt
git commit -m "R1: add rebase.txt"
echo "rebase feature 2" >> rebase.txt
git commit -am "R2: update rebase.txt"
git checkout main
echo "main change 2" >> main.txt
git commit -am "C4: update main.txt"
git checkout feature/rebase-demo
git rebase main
git log --oneline --graph --all
git checkout main
git merge feature/rebase-demo
git log --oneline --graph -8

########## 3. Squash (gom nhiều commit thành 1) ##########
git checkout -b feature/squash-demo
echo "squash 1" > squash.txt
git add squash.txt
git commit -m "S1: add squash.txt"
echo "squash 2" >> squash.txt
git commit -am "S2: fix typo"
echo "squash 3" >> squash.txt
git commit -am "S3: fix typo again"
git checkout main
git merge --squash feature/squash-demo
git status
git commit -m "feat: add squash feature (S1+S2+S3)"
git log --oneline --graph -8

########## 4. Stash: cất tạm thay đổi dang dở ##########
echo "work in progress" >> app.txt
echo "new file" > draft.txt
git status
# git stash mặc định chỉ cất file đã được track (app.txt), draft.txt (untracked) vẫn còn
git stash
git status
git stash pop
# Cất cả file untracked
git stash push --include-untracked -m "wip: draft"
git status
git stash list
# Lúc này working directory sạch, có thể chuyển branch để xử lý việc khác
git checkout -b hotfix/urgent
git checkout main
git stash pop
git status
# git stash apply   : lấy thay đổi nhưng vẫn giữ trong stash list
# git stash drop    : xoá 1 stash
git add .
git commit -m "C5: finish wip"

########## 5. Reset: soft / mixed / hard ##########
echo "reset 1" > reset.txt
git add reset.txt
git commit -m "X1: add reset.txt"
echo "reset 2" >> reset.txt
git commit -am "X2: update reset.txt"
git log --oneline -3

git reset --soft HEAD~1
git status
git commit -m "X2: update reset.txt (commit again)"

git reset --mixed HEAD~1
git status
git add reset.txt
git commit -m "X2: update reset.txt (commit again)"

git reset --hard HEAD~1
git status
cat reset.txt

########## 6. Reflog: tìm lại commit đã "mất" sau reset --hard ##########
git reflog -10
# Thay <COMMIT_HASH> bằng hash của commit "X2: ..." trong reflog
git reset --hard <COMMIT_HASH>
cat reset.txt

########## Dọn dẹp ##########
cd ~/git-labs
rm -rf ~/git-labs/git-playground
