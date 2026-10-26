# Section 6 – Thao tác cơ bản với Linux

Source code cho các bài lab của Section 6. Nội dung hướng dẫn: `sections/section_6/`.

Tất cả lab dùng chung **1 EC2 instance Amazon Linux 2023** tạo ở Lab 1 (`linux-lab-server`).
Các file `commands.sh` là **tập hợp lệnh tham khảo** theo thứ tự các bước trong bài lab,
không chạy cả file một lần — copy từng lệnh và chạy theo hướng dẫn.

| Folder | Bài lab |
|---|---|
| `lab1_ec2_ssh_basic_commands/` | Lab 1 – Tạo EC2 Linux, SSH & các lệnh cơ bản |
| `lab2_vim_nano/` | Lab 2 – Làm quen với trình soạn thảo Vim & Nano (`sample.txt` để thực hành) |
| `lab3_user_group/` | Lab 3 – Quản lý User, Group & quyền sudo |
| `lab4_file_permission/` | Lab 4 – Phân quyền & thay đổi owner của File/Folder |
| `lab5_process/` | Lab 5 – Quản lý Process |
| `lab6_service/` | Lab 6 – Quản lý Service với systemctl (`index.html`, `hello.sh`, `hello.service`) |
| `lab7_ebs_volume/` | Lab 7 – EBS Volume: partition, mount & mở rộng dung lượng |
| `lab8_cronjob/` | Lab 8 – Lập lịch tác vụ với Cron job (`script.sh`) |
| `lab9_ssh_key/` | Lab 9 – Thêm SSH key cho thành viên dự án |
| `linux_cheatsheet/` | Các lệnh Linux thường dùng khác (wget, curl, tar, zip, grep, find...) |

## Lưu ý
- Amazon Linux 2023 dùng trình quản lý gói `dnf` (lệnh `yum` vẫn chạy được vì là alias của `dnf`).
- Không commit private key (`*.pem`, `dev01`...) lên Git. Lab 9 hướng dẫn tự sinh key trên máy local.
- Luôn **Terminate EC2** và **xoá EBS Volume** tạo thêm ở Lab 7 sau khi học xong để tránh phát sinh chi phí.
