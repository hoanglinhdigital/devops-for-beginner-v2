# Section 7 – Thao tác cơ bản với Git

Source code cho các bài lab của Section 7. Nội dung hướng dẫn: `sections/section_7/`.

Các lab dùng chung **1 repository trên GitHub** (`demo-git`) tạo ở Lab 2, mỗi lab nối tiếp kết quả của lab trước.
Các file `commands.sh` là **tập hợp lệnh tham khảo** theo thứ tự các bước trong bài lab,
không chạy cả file một lần — copy từng lệnh và chạy trong **Git Bash** (Windows) hoặc Terminal (Mac/Linux).

| Folder | Bài lab |
|---|---|
| `lab1_install_git/` | Lab 1 – Cài đặt Git, SourceTree & clone repository đầu tiên |
| `lab2_github_ssh_key/` | Lab 2 – Tạo repository trên GitHub & cấu hình SSH key |
| `lab3_develop_branch/` | Lab 3 – Tạo nhánh develop, commit & push (`index.html`, `README.md`, `.gitignore` mẫu) |
| `lab4_protect_branch_pull_request/` | Lab 4 – Protect branch, nhánh feature & Pull Request (`about.html`) |
| `lab5_release_tag/` | Lab 5 – Nhánh release, merge vào main & đánh tag (`VERSION`) |
| `lab6_git_revert/` | Lab 6 – Git log, show & revert |
| `lab7_resolve_conflict/` | Lab 7 – Giả lập & xử lý conflict (`test.txt`) |
| `git_merge_rebase_squash/` | Thực hành Merge / Rebase / Squash, stash, reset, reflog (repo local, không cần GitHub) |
| `lab8_codecommit/` | Lab 8 – Sử dụng AWS CodeCommit (`ssh_config` mẫu) |
| `git_cheatsheet/` | Các lệnh Git thường dùng |

## Lưu ý
- Thay `<GITHUB_USERNAME>`, `<YOUR_EMAIL>`... bằng thông tin của bạn trước khi chạy lệnh.
- Không commit private key (`id_ed25519`, `codecommit_rsa`...), file `.env`, password, access key lên Git.
- Branch mặc định của repository mới trên GitHub là `main` (slide cũ dùng `master`, cách làm hoàn toàn giống nhau).
- CodeCommit (Lab 8) cần IAM User (không dùng root user). Xoá repository CodeCommit, SSH key trên IAM sau khi học xong.
