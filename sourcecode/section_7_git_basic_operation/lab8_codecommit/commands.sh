#!/bin/bash
# Lab 8 - Sử dụng AWS CodeCommit
# Copy từng lệnh và chạy theo hướng dẫn trong bài lab, không chạy cả file.
# Tham khảo: https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-ssh-windows.html

########## Bước 1: Tạo repository trên CodeCommit (AWS Console) ##########
# Region: ap-southeast-1 (Singapore)
# Repository name: demo-codecommit | Description: Lab 8 - Section 7

########## Bước 2: Chuẩn bị IAM User ##########
# IAM -> Users -> Create user: codecommit-lab-user (không cần Console access)
# Permissions: Attach policies directly -> AWSCodeCommitPowerUser

########## Bước 3: Sinh SSH key RSA cho CodeCommit (PC Local - Git Bash) ##########
# IAM chỉ chấp nhận SSH public key dạng ssh-rsa (>= 2048 bit), KHÔNG hỗ trợ ed25519
ssh-keygen -t rsa -b 4096 -C "codecommit-lab-user" -f ~/.ssh/codecommit_rsa
cat ~/.ssh/codecommit_rsa.pub
clip < ~/.ssh/codecommit_rsa.pub

########## Bước 4: Upload public key cho IAM User ##########
# IAM -> Users -> codecommit-lab-user -> Security credentials
#   -> SSH public keys for AWS CodeCommit -> Upload SSH public key -> dán nội dung codecommit_rsa.pub
# Ghi lại SSH key ID (dạng APKAxxxxxxxxxxxxxxxx)

########## Bước 5: Cấu hình ~/.ssh/config ##########
code ~/.ssh/config
# Thêm nội dung trong file ssh_config (thư mục lab8_codecommit), thay <SSH_KEY_ID>

########## Bước 6: Kiểm tra kết nối ##########
ssh git-codecommit.ap-southeast-1.amazonaws.com
# Kết quả mong đợi: You have successfully authenticated over SSH. You can use Git to interact with AWS CodeCommit.

########## Bước 7: Clone repository ##########
cd ~/git-labs
git clone ssh://git-codecommit.ap-southeast-1.amazonaws.com/v1/repos/demo-codecommit
cd demo-codecommit

########## Bước 8: Commit đầu tiên trên main, tạo nhánh feature ##########
echo "# demo-codecommit" > README.md
git add README.md
git commit -m "chore: init repository"
git branch -M main
git push -u origin main

git checkout -b feature/F001
echo "<h1>Hello from CodeCommit</h1>" > index.html
git add index.html
git commit -m "feat(F001): add index page"
git push -u origin feature/F001

########## Bước 9: Tạo, review & merge Pull Request trên CodeCommit Console ##########
# Repositories -> demo-codecommit -> Pull requests -> Create pull request
#   Destination: main | Source: feature/F001 -> Compare -> Title -> Create pull request
# Tab Changes: xem diff, comment -> Merge -> Fast forward merge -> Delete source branch

########## Bước 10: Cập nhật main local ##########
git checkout main
git pull origin main
git log --oneline --graph -5

########## Dọn dẹp ##########
# CodeCommit -> Repositories -> demo-codecommit -> Delete repository
# IAM -> Users -> codecommit-lab-user -> Security credentials -> xoá SSH public key -> Delete user
rm -rf ~/git-labs/demo-codecommit
# Xoá block Host git-codecommit.*.amazonaws.com trong ~/.ssh/config
# rm ~/.ssh/codecommit_rsa ~/.ssh/codecommit_rsa.pub
