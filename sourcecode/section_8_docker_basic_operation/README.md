# Section 8 – Thao tác cơ bản với Docker

Source code cho các bài lab của Section 8. Nội dung hướng dẫn: `sections/section_8/`.

Các lab chạy trên **Docker Desktop** (Windows/MacOS) hoặc **EC2 Amazon Linux 2023** đã cài Docker (Lab 1).
Các file `commands.sh` là **tập hợp lệnh tham khảo** theo thứ tự các bước trong bài lab,
không chạy cả file một lần — copy từng lệnh và chạy trong Terminal / Git Bash, tại thư mục `section_8_docker_basic_operation`.

| Folder | Bài lab |
|---|---|
| `lab1_install_docker/` | Lab 1 – Cài đặt Docker & Docker Compose, đăng ký Docker Hub |
| `lab2_basic_commands/` | Lab 2 – Thao tác cơ bản với Image & Container |
| `lab3_dockerfile/` | Lab 3 – Build & Run container đơn giản với Dockerfile (`httpd`) |
| `lab4_cmd_entrypoint/` | Lab 4 – Phân biệt CMD và ENTRYPOINT (`Dockerfile-1/2/3`) |
| `lab5_multi_stage/` | Lab 5 – Multi-stage Dockerfile (Node.js build → `httpd`) |
| `lab6_compose_simple/` | Lab 6 – Docker Compose: ứng dụng Node.js đơn giản, bind mount |
| `lab7_compose_multi/` | Lab 7 – Docker Compose: Node.js + Redis + MySQL, named volume, healthcheck |
| `lab8_compose_load_balancer/` | Lab 8 – Docker Compose: NGINX load balancer trước 3 replica Node.js |
| `lab9_ecr_ecs/` | Lab 9 – Push image lên Amazon ECR & chạy task trên Amazon ECS Fargate |
| `docker_cheatsheet/` | Các lệnh Docker & Docker Compose thường dùng |

## Lưu ý
- Lab 7, Lab 8: copy `.env.example` thành `.env` và đổi password. File `.env` đã được gitignore, không commit lên Git.
- Port `8080` được dùng cho nhiều lab: hãy dọn dẹp container của lab trước (`docker rm -f ...` / `docker compose down`) trước khi chạy lab sau.
- So với phiên bản cũ: dùng `docker compose` (Compose V2) thay cho `docker-compose`, bỏ thuộc tính `version` trong file compose,
  nâng cấp `node:14` → `node:20`, `mysql:5.7` → `mysql:8.4`, AWS Cloud9 được thay bằng EC2 Amazon Linux 2023.
- Lab 9 tạo resource trên AWS (ECR, ECS Fargate): xoá ECS cluster, task definition, ECR repository sau khi học xong.
