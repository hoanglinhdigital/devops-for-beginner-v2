# Outline khoá học: DevOps on AWS for Beginner – Tiếng Việt

> Khi thêm/sửa/xoá chapter trong sidebar của `index.html`, cập nhật file này tương ứng (và ngược lại).
> Nguồn nội dung tham chiếu: `slide_old/` (phiên bản PowerPoint cũ).

## Section 1. Giới thiệu về giảng viên & khoá học
Nguồn: `slide_old/1.Gioi_thieu_giang_vien_va_khoa_hoc.pptx`

| Chapter | Tên chapter | File | Nội dung chính |
|---|---|---|---|
| 1 | Giới thiệu giảng viên | `sections/section_1/chapter_1.html` | >whoami (kinh nghiệm, chứng chỉ, training), các khoá học đã xuất bản, bản đồ học viên, course engagement |
| 2 | Khoá học này dành cho ai? | `sections/section_1/chapter_2.html` | Đối tượng phù hợp / không phù hợp (định hướng Cloud/DevOps Engineer, SRE), yêu cầu đầu vào (6 tháng IT, AWS cơ bản, Linux, Git, AWS account) |
| 3 | Nội dung, cấu trúc & mục tiêu khoá học | `sections/section_1/chapter_3.html` | Nội dung khoá học (DevOps & CICD, ôn AWS, Linux/Git/Docker, Terraform, Jenkins/Github Actions/CodePipeline, SAM, Kubernetes & EKS, GitOps, Final Assignment), lộ trình, cấu trúc (Lý thuyết 25% / Thực hành 70% / Other 5%), mục tiêu sau khi hoàn thành |
| 4 | Lưu ý cho học viên & checklist chuẩn bị | `sections/section_1/chapter_4.html` | Phong cách & phạm vi khoá học, lưu ý về lab, chi phí, bảo mật; công cụ (Git/Github, VS Code, AWS CLI, Terraform, Docker, AWS SAM CLI, kubectl, MySQL Workbench, DrawIO); checklist chuẩn bị |
| 5 | Tương tác với giảng viên như thế nào? | `sections/section_1/chapter_5.html` | Udemy Q&A, Discord, Facebook DM (khẩn cấp), Youtube; cách đặt câu hỏi hiệu quả |

## Section 3. Giới thiệu về DevOps & CICD
Nguồn: `slide_old/3.Gioi_thieu_ve_devops_va_CICD.pptx`

| Chapter | Tên chapter | File | Nội dung chính |
|---|---|---|---|
| 1 | DevOps là gì? Hiểu đúng & hiểu sai về DevOps | `sections/section_3/chapter_1.html` | Định nghĩa & mục tiêu DevOps, đặc điểm chính, vòng đời DevOps (Plan → Monitor), hiểu đúng (văn hoá, triết lý) / hiểu sai (công nghệ, tools, chức danh), trade-off khi áp dụng |
| 2 | Các nguyên tắc của DevOps & CICD | `sections/section_3/chapter_2.html` | 5 nguyên tắc (Automation, CI, CD, Monitoring & Feedback, Self-service), định nghĩa CICD, CI vs Continuous Delivery vs Continuous Deployment, sơ đồ CICD pipeline điển hình |
| 3 | DevOps thay đổi cách làm việc & vai trò DevOps Engineer | `sections/section_3/chapter_3.html` | Quy trình khi không có DevOps (“ném qua tường”, vấn đề giữa Dev & Ops) vs khi có DevOps, vai trò & trách nhiệm của DevOps Engineer trong dự án |
| 4 | Ma trận DevOps tools & CICD | `sections/section_3/chapter_4.html` | DevOps tools theo từng giai đoạn, CICD concept độc lập với công cụ, không cần biết hết mọi tool (“vô chiêu thắng hữu chiêu”), CICD là “may đo”, pipeline đơn giản vs phức tạp |
| 5 | Trở thành DevOps Engineer: kiến thức cần có & cơ hội việc làm | `sections/section_3/chapter_5.html` | Các mảng kiến thức cần trang bị (Cloud, OS, VCS, Network/DB/Security, IaC & CICD, Docker/K8s, Monitoring, soft skill), phần được học trong khoá, lưu ý “bình tĩnh”, mức lương tham khảo, các con đường vào nghề |


## Section 4. Giới thiệu & ôn lại kiến thức AWS
Nguồn: `slide_old/4.1.Gioi_thieu_ve_AWS.pptx`, `slide_old/4.2.On_lai_kien_thuc_aws.pptx`

| Chapter | Tên chapter | File | Nội dung chính |
|---|---|---|---|
| 1 | Giới thiệu về Amazon Web Services (AWS) | `sections/section_4/chapter_1.html` | AWS là gì, đặc điểm chính, lịch sử hình thành (2006 → GenAI), thị phần & doanh thu, Werner Vogels, các loại hệ thống triển khai trên AWS, trade-off khi chọn AWS, khách hàng tiêu biểu & AWS tại Việt Nam |
| 2 | Hệ thống chứng chỉ AWS | `sections/section_4/chapter_2.html` | 4 cấp độ (Foundational / Associate / Professional / Specialty), lộ trình gợi ý cho DevOps (SAA → DVA → DOP), FAQ: chứng chỉ có quan trọng, không học dump, có thể bỏ qua Associate |
| 3 | Hạ tầng toàn cầu: Region, AZ, Local Zone, Edge Location | `sections/section_4/chapter_3.html` | Số liệu global infrastructure, định nghĩa Region/AZ/Local Zone/Edge Location, private region (China), 4 tiêu chí chọn Region, opt-in region, Single-AZ vs Multi-AZ vs Multi-Region |
| 4 | Tổng quan các dịch vụ chính trên AWS | `sections/section_4/chapter_4.html` | Bản đồ dịch vụ theo nhóm (Compute & Container, Storage, Networking, Database, Security, Monitoring & Governance, Messaging, Deployment, nhóm khác), dịch vụ hay dùng, managed service vs tự quản lý trên EC2 |
| 5 | Ôn tập: IAM, VPC & Networking, Load Balancer | `sections/section_4/chapter_5.html` | IAM (User, Group, Role, Policy, STS), VPC/Subnet/Route table/IGW/NAT, thiết kế VPC 3 tầng 2 AZ, thiết kế Security Group (stateful, SG chaining), ELB (Listener, Rule, Target Group, 4 loại LB) |
| 6 | Ôn tập: S3, RDS & CloudFront (CDN) | `sections/section_4/chapter_6.html` | S3 (storage class, lifecycle, versioning, bảo mật), RDS (Multi-AZ, Read Replica, các mô hình triển khai, Aurora cluster endpoint, RDS Proxy), CloudFront (Edge cache, static website trên S3, behavior & thứ tự behavior, OAC) |
| 7 | Ôn tập: Serverless, Container, Monitoring & Messaging | `sections/section_4/chapter_7.html` | Serverless (API Gateway, Cognito, Lambda + use cases), ECR/ECS/Fargate, CloudWatch (Metrics, Logs, Alarm, Synthetics, RUM) & CloudTrail, decoupling với SQS/SNS/EventBridge (fan-out, DLQ) |

## Section 5. Infra as Code (IaC) sử dụng Terraform
Nguồn: `slide_old/5.Infra_as_Code_using_Terraform.pptx`, `source_code_old/5-iac-using-terraform/`
Source code lab: `sourcecode/section_5_IaC_using_Terraform/` (Terraform >= 1.10, AWS provider ~> 6.0)

| Chapter | Tên chapter | File | Nội dung chính |
|---|---|---|---|
| 1 | Infra as Code (IaC) là gì? Tại sao cần IaC | `sections/section_5/chapter_1.html` | Mục tiêu section, định nghĩa IaC, vấn đề của triển khai thủ công, ưu điểm IaC, 5 bước triển khai IaC, thủ công vs IaC, FAQ "chỉ 1 môi trường có cần IaC?" |
| 2 | Các công cụ Infra as Code thường dùng | `sections/section_5/chapter_2.html` | Provisioning (CloudFormation, CDK, Terraform, ARM/Bicep, GCP Deployment Manager, OpenTofu/Pulumi) vs Configuration Management (Ansible, Puppet, Chef), so sánh CFN/CDK/Terraform, FAQ "tool nào tốt nhất?" |
| 3 | Giới thiệu Terraform: thành phần & cơ chế hoạt động | `sections/section_5/chapter_3.html` | Thành phần (template, provider, resource/data source, CLI, state, variable/output/module), cơ chế hoạt động, init/plan/apply/destroy, cú pháp HCL & tham chiếu, cấu trúc thư mục project |
| 4 | Lab 1: Cài đặt môi trường làm việc với Terraform | `sections/section_5/chapter_4.html` | Cài AWS CLI v2 + `aws configure`, cài Terraform, VS Code extension, thư mục `terraform-labs`, tra cứu Terraform docs/Registry |
| 5 | Lab 2: Template Terraform đầu tiên – EC2 & Security Group | `sections/section_5/chapter_5.html` | Tạo keypair bằng ssh-keygen, EC2 + SG trong Default VPC, data source `aws_ami`, init/plan/apply, SSH, đổi instance type (update in-place vs replace), destroy |
| 6 | Lab 3: Variable, Map & Variable file | `sections/section_5/chapter_6.html` | Kiểu dữ liệu variable, map instance type theo môi trường, thứ tự ưu tiên giá trị, terraform.tfvars, `-var`, `-var-file`, validation, `merge()` |
| 7 | Lab 4: Terraform Output | `sections/section_5/chapter_7.html` | Output block, Elastic IP, `terraform output -raw/-json`, SSH bằng output |
| 8 | Lab 5: Chia module & liên kết module bằng Output | `sections/section_5/chapter_8.html` | Root/child module, module security + compute, output module này làm input module khác, provider chỉ ở root |
| 9 | Lab 6: Deploy một VPC hoàn chỉnh + resources | `sections/section_5/chapter_9.html` | Module networking (2 public + 2 private subnet, RTB, IGW, NAT GW), deploy 2 part, tái sử dụng module security/compute, `depends_on` |
| 10 | Lab 7: Sử dụng module có sẵn từ Terraform Registry | `sections/section_5/chapter_10.html` | Terraform Registry, `terraform-aws-modules/vpc/aws`, version constraint, `single_nat_gateway`, tự viết vs dùng module có sẵn |
| 11 | Lab 8: Bài tập cuối chương – ALB, Auto Scaling & MongoDB | `sections/section_5/chapter_11.html` | Phân tích thiết kế → 5 module (network, security, bastion, storage, application), SG chaining, Launch Template + ASG + ALB + 2 Target Group + listener rule, `user_data`, `templatefile()`, SSH qua Bastion |
| 12 | Terraform State & các phương án quản lý State | `sections/section_5/chapter_12.html` | State là gì, thông tin nhạy cảm, locking, local vs Git vs S3 vs HCP Terraform, S3 native lock (`use_lockfile`) thay DynamoDB, lệnh `terraform state`, import, drift |
| 13 | Lab 9: Sử dụng S3 để quản lý Terraform State | `sections/section_5/chapter_13.html` | Tạo S3 bucket (versioning, encryption), cấu hình backend s3, quan sát lock file & state version, lỗi state lock khi chạy đồng thời |
| 14 | Lab 10: Triển khai Multi-environment, Multi-region | `sections/section_5/chapter_14.html` | dev (Singapore) & test (Tokyo) dùng chung 1 bộ module, state key riêng mỗi môi trường, promote thay đổi, so sánh thư mục riêng vs workspace vs Terragrunt |
| 15 | Tổng kết section & dọn dẹp resource | `sections/section_5/chapter_15.html` | Tổng kết kiến thức, lộ trình 10 lab, checklist dọn dẹp ở cả 2 region, chủ đề nên học thêm |

## Section 6. Thao tác cơ bản với Linux
Nguồn: `slide_old/6.Thao_tac_co_ban_voi_Linux.pptx`, `source_code_old/6-linux-basic-operation/`
Source code lab: `sourcecode/section_6_linux_basic_operation/` (Amazon Linux 2023, `dnf`, `systemctl`; tất cả lab dùng chung 1 EC2 `linux-lab-server`)

| Chapter | Tên chapter | File | Nội dung chính |
|---|---|---|---|
| 1 | Giới thiệu Linux & các bản phân phối (Distro) | `sections/section_6/chapter_1.html` | Mục tiêu section, lịch sử Linux (1991 → Cloud/Container), kiến trúc Kernel/Shell/User space, họ distro (Debian/Red Hat/khác) & package manager, distro theo nhóm người dùng, Amazon Linux 2023 vs Ubuntu, AL2 EOL, trade-off Linux vs Windows Server |
| 2 | Lab 1: Tạo EC2 Linux, kết nối SSH & các lệnh cơ bản | `sections/section_6/chapter_2.html` | Key pair, SG (22 My IP, 80), EC2 t3.micro AL2023, `ssh -i`, hostname/whoami/id/uname/os-release, cấu trúc thư mục `/`, cd/pwd/ls/cat, mkdir/touch/cp/mv/rm, redirect `>`/`>>`, man/history |
| 3 | Lab 2: Làm quen với trình soạn thảo Vim & Nano | `sections/section_6/chapter_3.html` | `dnf install vim-enhanced nano`, các mode của Vim, lưu/thoát, dd/yy/p/u, tìm kiếm & thay thế, di chuyển con trỏ, phím tắt Nano |
| 4 | User, Group & phân quyền trong Linux | `sections/section_6/chapter_4.html` | UID/GID, primary/secondary group, root, sudo/sudoers, system user, đọc `ls -l`, ý nghĩa r/w/x với file & folder, quyền dạng số (octal), luồng kiểm tra quyền owner → group → other, least privilege |
| 5 | Lab 3: Quản lý User, Group & quyền sudo | `sections/section_6/chapter_5.html` | Bật PasswordAuthentication qua `sshd_config.d`, useradd/passwd, login bằng password, groupadd, `usermod -aG`, `visudo -f /etc/sudoers.d/...`, usermod/groupmod, tắt lại password login |
| 6 | Lab 4: Phân quyền & thay đổi owner của File/Folder | `sections/section_6/chapter_6.html` | Đọc quyền `/etc/passwd` vs `/etc/shadow`, umask, `chmod 750`, quyền x trên thư mục cha, `chown user:group`, `chmod g+w`/symbolic, thư mục dùng chung `/opt/project` với `chown -R` |
| 7 | Process & Service trong Linux | `sections/section_6/chapter_7.html` | PID/PPID, systemd PID 1, trạng thái process, foreground/background, signal (SIGTERM, SIGKILL, SIGINT, SIGHUP), systemctl/journalctl, chạy tay vs service vs container |
| 8 | Lab 5: Quản lý Process | `sections/section_6/chapter_8.html` | ps/ps -ef/ps aux/ps -l, top, `&`, jobs/fg/bg/Ctrl+Z, kill/kill -9/pkill/pgrep, process của user khác, free/nproc/uptime |
| 9 | Lab 6: Quản lý Service với systemctl | `sections/section_6/chapter_9.html` | Cài httpd + trang web, start/stop/restart/reload/status, enable + reboot, journalctl & access_log, list-units, tự viết `hello.service` (Restart=always), daemon-reload |
| 10 | Lab 7: EBS Volume – Partition, Mount & mở rộng dung lượng | `sections/section_6/chapter_10.html` | Block device/partition/file system/mount point, NVMe device name, mở rộng root (growpart + xfs_growfs), attach volume 10 GiB, fdisk, mkfs.xfs, mount `/data`, fstab theo UUID + nofail, modify volume 15 GiB, giới hạn 6 giờ/lần modify |
| 11 | Lab 8: Lập lịch tác vụ với Cron job | `sections/section_6/chapter_11.html` | Cú pháp 5 trường cron & ví dụ, cài `cronie` trên AL2023, script ghi log, `crontab -e` vs `/etc/crontab`, journalctl crond, timezone UTC, PATH trong cron |
| 12 | Lab 9: Thêm SSH key cho thành viên dự án | `sections/section_6/chapter_12.html` | Cơ chế public/private key, `ssh-keygen -t ed25519`, user không password, `~/.ssh` 700 / `authorized_keys` 600, `~/.ssh/config`, thu hồi quyền, Session Manager/EC2 Instance Connect |
| 13 | Tổng kết, lệnh thường dùng khác & dọn dẹp resource | `sections/section_6/chapter_13.html` | Tổng kết & lộ trình 9 lab, wget/curl, tar/zip, head/tail/less/grep/find, df/du/free, pipe & redirect, biến môi trường, mạng; checklist dọn dẹp (EC2, EBS, Elastic IP, SG, key pair, billing) |

## Section 7. Thao tác cơ bản với Git
Nguồn: `slide_old/7.Thao_tac_co_ban_voi_Git.pptx`, `source_code_old/7-git-basic-operation/`
Source code lab: `sourcecode/section_7_git_basic_operation/` (Git Bash, GitHub repository `demo-git` dùng chung cho Lab 2 → Lab 7, branch mặc định `main`)

| Chapter | Tên chapter | File | Nội dung chính |
|---|---|---|---|
| 1 | Giới thiệu Git & hệ thống quản lý phiên bản (VCS) | `sections/section_7/chapter_1.html` | Mục tiêu section, Git là gì (Linus Torvalds 2005), không có VCS vs dùng Git, đặc trưng (distributed, content-addressable, branch nhẹ, lịch sử chỉ thêm), Centralized vs Distributed VCS, nhà cung cấp Git (GitHub, GitLab, Bitbucket, CodeCommit, Azure Repos), trade-off |
| 2 | Kiến trúc & vòng đời (life cycle) của Git | `sections/section_7/chapter_2.html` | Repository/commit/branch/merge/remote/clone/pull/push, HEAD/origin/fetch/tag/PR, 4 khu vực Working Directory → Staging → Local repo → Remote, life cycle Create → Modify → Stage → Commit → Push, trạng thái file, `.git`, `.gitignore` |
| 3 | Lab 1: Cài đặt Git, SourceTree & clone repository đầu tiên | `sections/section_7/chapter_3.html` | Cài Git/Git Bash, `git config --global` (user, defaultBranch, pull.rebase, autocrlf, editor), SourceTree, clone `octocat/Hello-World`, `git branch -a`, mở bằng VS Code |
| 4 | Lab 2: Tạo repository trên GitHub & cấu hình SSH key | `sections/section_7/chapter_4.html` | Repo `demo-git` (Public để dùng Ruleset với GitHub Free), `ssh-keygen -t ed25519`, ssh-agent (Git Bash & Windows service), thêm public key vào GitHub, `ssh -T git@github.com`, clone SSH vs HTTPS |
| 5 | Lab 3: Tạo nhánh develop, commit & push | `sections/section_7/chapter_5.html` | `checkout -b develop` / `switch -c`, `status`, `diff`, `add`, `commit`, Conventional Commits, `push -u`, `.gitignore` mẫu |
| 6 | Các mô hình Git Workflow & chiến lược quản lý branch | `sections/section_7/chapter_6.html` | Centralized, Feature Branch (GitHub Flow), Gitflow (main/develop/feature/bugfix/release/hotfix), mapping branch ↔ môi trường Dev/Test/Staging/Production, trade-off, trunk-based |
| 7 | Lab 4: Protect branch, nhánh feature & Pull Request | `sections/section_7/chapter_7.html` | GitHub Ruleset bảo vệ main & develop (PR bắt buộc, chặn xoá, chặn force push), lỗi GH013 khi push trực tiếp, `feature/F001`, tạo/review/merge PR, `fetch --prune` |
| 8 | Lab 5: Nhánh release, merge vào main & đánh tag | `sections/section_7/chapter_8.html` | `release/v0.1`, file VERSION, PR release → main, annotated vs lightweight tag, `git push origin v0.1`, back-merge vào develop, GitHub Release |
| 9 | Lab 6: Git log, show & revert | `sections/section_7/chapter_9.html` | `git log` (oneline, graph, theo file/tác giả), `git show`, `git revert` (tạo commit đảo ngược), revert commit revert, `revert -m 1` cho merge commit, so sánh revert vs reset |
| 10 | Lab 7: Giả lập & xử lý conflict trên Git | `sections/section_7/chapter_10.html` | Dev A/Dev B (2 bản clone) sửa cùng dòng `test.txt`, PR sau bị conflict, `git pull origin develop`, dấu conflict & Accept Current/Incoming/Both, `merge --abort`, cách hạn chế conflict |
| 11 | Merge vs Rebase vs Squash & các lệnh stash, reset | `sections/section_7/chapter_11.html` | So sánh lịch sử (gitGraph) merge/rebase/squash, trade-off, quy tắc vàng của rebase, `stash` (apply/pop/include-untracked), `reset --soft/--mixed/--hard`, `reflog`; thực hành trên repo local `git-playground` |
| 12 | Lab 8: Sử dụng AWS CodeCommit | `sections/section_7/chapter_12.html` | Trạng thái CodeCommit (mở lại cho khách hàng mới 11/2025), repo `demo-codecommit`, IAM User `AWSCodeCommitPowerUser`, SSH key RSA (IAM không hỗ trợ ed25519), SSH key ID trong `~/.ssh/config`, PR & kiểu merge trên Console, dọn dẹp |
| 13 | Best practice khi sử dụng Git, tổng kết & dọn dẹp resource | `sections/section_7/chapter_13.html` | 10 best practice (branch, atomic commit, message, pull before push, review, resolve conflict, tag, backup, không commit secret, hạn chế viết lại lịch sử), tổng kết & bảng lệnh, dọn dẹp GitHub/AWS/local, tài liệu tham khảo |

## Section 8. Thao tác cơ bản với Docker
Nguồn: `slide_old/8.Thao_tac_co_ban_voi_Docker.pptx`, `source_code_old/8-docker-basic-operation/`
Source code lab: `sourcecode/section_8_docker_basic_operation/` (Docker Desktop hoặc EC2 Amazon Linux 2023 `docker-lab-server` thay cho Cloud9; Compose V2 `docker compose`; `node:20`, `mysql:8.4`)

| Chapter | Tên chapter | File | Nội dung chính |
|---|---|---|---|
| 1 | Container là gì? Tại sao cần Container? | `sections/section_8/chapter_1.html` | Mục tiêu section, câu chuyện xung đột thư viện trên VM, vấn đề khi deploy trên VM, container giải quyết thế nào, VM vs Container, lợi ích, trade-off, namespaces/cgroups, OCI |
| 2 | Docker là gì? Kiến trúc & các thành phần cơ bản | `sections/section_8/chapter_2.html` | Image/container/Dockerfile/registry/volume/network, Docker daemon – client – registry, image layer & container layer, các bước build → run, Docker vs Podman/containerd, tag `latest`, kiến trúc CPU |
| 3 | Lab 1: Cài đặt Docker & Docker Compose, đăng ký Docker Hub | `sections/section_8/chapter_3.html` | Docker Desktop (WSL 2 / MacOS), EC2 AL2023 t3.small 20 GB (`dnf install docker`, group docker, Compose & Buildx plugin), `hello-world`, Docker Hub + Personal Access Token, rate limit |
| 4 | Lab 2: Thao tác cơ bản với Image & Container | `sections/section_8/chapter_4.html` | Vòng đời container, pull/images/inspect/history, `run -d -p --name`, ps/ps -a, logs -f, stop/start/restart, `exec -it`, `-it`/`-dit`/`--rm`, stats, rm/rmi, `system prune` |
| 5 | Dockerfile & các chỉ thị cơ bản | `sections/section_8/chapter_5.html` | FROM/WORKDIR/COPY/ADD/RUN/ENV/EXPOSE/CMD/ENTRYPOINT, build context & `.dockerignore`, COPY vs ADD, CMD vs ENTRYPOINT, exec vs shell form, multi-stage, best practice |
| 6 | Lab 3: Build & Run container đơn giản với Dockerfile | `sections/section_8/chapter_6.html` | Dockerfile `httpd:2.4` + COPY web + ENV/RUN, `docker build -t`, run `-p 8080:80`, `/version.txt`, build tag 2.0 & layer cache, rollback bằng image cũ |
| 7 | Lab 4: Phân biệt CMD và ENTRYPOINT | `sections/section_8/chapter_7.html` | `image inspect --format`, alpine-1/2/3 với 6 kịch bản, tham số nối vào ENTRYPOINT / thay thế CMD, lỗi `exec: "-alh"`, `--entrypoint` |
| 8 | Lab 5: Multi-stage Dockerfile | `sections/section_8/chapter_8.html` | Webpack app build bằng `node:20` (stage 1) → `httpd:2.4` (stage 2), `COPY --from`, so sánh single (~1.7 GB) vs multi-stage (~175 MB), `--target`, `builder prune` |
| 9 | Docker Compose – giới thiệu & cú pháp | `sections/section_8/chapter_9.html` | Compose dùng cho local/CI, services/build/image/ports/volumes/environment/depends_on/healthcheck, `.env`, Compose V2 & bỏ `version`, bind mount vs named volume, các lệnh, trade-off |
| 10 | Lab 6: Docker Compose – ứng dụng Node.js đơn giản | `sections/section_8/chapter_10.html` | Express app, `docker-compose.yaml` 1 service, bind mount `./web:/app` + anonymous volume `node_modules`, sửa HTML thấy ngay, `up/ps/logs/exec/restart/down` |
| 11 | Lab 7: Docker Compose – Multi container (Node.js, Redis, MySQL) | `sections/section_8/chapter_11.html` | web + cache (redis:7-alpine) + db (mysql:8.4), DNS theo tên service, `.env` password, named volume `db-data`, init.sql, healthcheck + `service_healthy`, MySQL Workbench qua 3306, dữ liệu còn sau `down` |
| 12 | Lab 8: Docker Compose – Load Balancer với NGINX | `sections/section_8/chapter_12.html` | NGINX upstream round-robin trước 3 replica (`deploy.replicas`, port ngẫu nhiên), stateless + Redis dùng chung, header X-Upstream, `--scale web=5` + restart nginx, failover khi stop 1 replica (`proxy_connect_timeout`) |
| 13 | Giới thiệu Amazon ECR & Amazon ECS | `sections/section_8/chapter_13.html` | ECR registry/repository/image tag, scanning, lifecycle; ECS cluster/task definition/task/service/Service Connect, mapping Compose ↔ ECS, kiến trúc mẫu ALB + Fargate + RDS + ElastiCache, Fargate vs EC2, chi phí |
| 14 | Lab 9: Push image lên ECR & chạy container trên ECS Fargate | `sections/section_8/chapter_14.html` | Repo `my-httpd`, `build --platform linux/amd64`, `ecr get-login-password`, tag/push, cluster `docker-lab-cluster`, task definition `my-httpd-task` (0.25 vCPU/0.5 GB), run task public IP, CloudWatch Logs, version 2.0, dọn dẹp |
| 15 | Docker cheat sheet, tổng kết & dọn dẹp resource | `sections/section_8/chapter_15.html` | Tổng kết & lộ trình 9 lab, bảng lệnh image/container/compose, tài liệu tham khảo, checklist dọn dẹp AWS (ECS, ECR, ALB, EC2, EBS, SG, Cloud9) & local (`system prune`) |

## Section 9. CI/CD với AWS CodePipeline
Nguồn: `slide_old/9.CodePipeline-CodeBuild-CodeCommit-CodeDeploy.pptx`, `source_code_old/9-codepipeline/`
Source code lab: `sourcecode/section_9_code_pipeline/` (GitHub + AWS CodeConnections thay CodeCommit; repo mẫu `java-elasticbeanstalk-sample`, `simple-vue-webpack`, `nodejs-random-color`; CodeBuild image `amazonlinux-x86_64-standard:5.0`; pipeline V2; Terraform stack `terraform_ecs_stack` dùng chung Lab 6 → Lab 9, không NAT Gateway)

| Chapter | Tên chapter | File | Nội dung chính |
|---|---|---|---|
| 1 | Giới thiệu AWS Developer Tools: CodeCommit, CodeBuild, CodeDeploy, CodePipeline | `sections/section_9/chapter_1.html` | Mục tiêu section, vai trò 4 dịch vụ, kiến trúc pipeline Source → Build → Approval → Deploy, mapping giai đoạn CI/CD ↔ dịch vụ, trade-off vs Jenkins/GitHub Actions, lộ trình 9 lab, trạng thái CodeCommit, chi phí |
| 2 | AWS CodeBuild & file buildspec.yml | `sections/section_9/chapter_2.html` | Build project (source, environment, service role, artifacts, logs), cấu trúc buildspec (env variables/parameter-store/secrets-manager, 4 phase, artifacts, cache), biến có sẵn, buildspec trong repo vs Console, managed vs custom image, privileged mode, Docker Hub rate limit |
| 3 | Lab 1: Chuẩn bị source code trên GitHub & tạo kết nối GitHub | `sections/section_9/chapter_3.html` | Fork & clone 3 repo mẫu, AWS CodeConnections (GitHub App) `github-connection`, S3 bucket `codebuild-artifact-<suffix>` |
| 4 | Lab 2: CodeBuild – Build Java project, lưu artifact lên S3 | `sections/section_9/chapter_4.html` | buildspec Maven + `corretto17`, `discard-paths`, cache `~/.m2`, project `java-project-build`, phase details & log, artifact `demo-v0.0.2.jar` trên S3, webhook (tuỳ chọn) |
| 5 | Lab 3: CodeBuild – Build Node.js (Webpack), upload file tĩnh lên S3 | `sections/section_9/chapter_5.html` | `npm install` / `npm run build`, biến môi trường `S3_BUCKET`, No artifacts + `aws s3 cp --recursive`, inline policy least privilege |
| 6 | Lab 4: CodeBuild – Build Docker image & push lên ECR | `sections/section_9/chapter_6.html` | ECR `nodejs-random-color`, Dockerfile `node:20-alpine` từ ECR Public, privileged mode, `aws sts get-caller-identity` lấy Account ID, tag `latest` + commit SHA, `AmazonEC2ContainerRegistryPowerUser` |
| 7 | AWS CodePipeline & AWS CodeDeploy | `sections/section_9/chapter_7.html` | Pipeline/stage/action/artifact/transition/execution, pipeline V2 & execution mode, các action deploy (Beanstalk, ECS, ECS Blue/Green, CodeDeploy), CodeDeploy application/deployment group/deployment config/revision, AppSpec cho ECS, ECS native Blue/Green |
| 8 | Lab 5: CodePipeline – GitHub → CodeBuild → Elastic Beanstalk | `sections/section_9/chapter_8.html` | IAM role Beanstalk, environment Java Corretto 17 single instance (port 5000), pipeline `java-beanstalk-pipeline`, trigger khi push, Release change, dọn dẹp Beanstalk |
| 9 | Các chiến lược deployment: Rolling, Blue/Green, Canary, Linear | `sections/section_9/chapter_9.html` | Tại sao cần chiến lược deployment (yếu tố non-functional, vị trí trong pipeline, tiêu chí: downtime, blast radius, rollback, chi phí, độ phức tạp, tính nhất quán); All at once, Rolling, Immutable, Blue/Green, Canary, Linear; sơ đồ trên ECS; bảng trade-off (downtime, ảnh hưởng, rollback, tài nguyên); hỗ trợ trên Beanstalk/ECS/CodeDeploy/Lambda; deploy ≠ release; backward compatibility |
| 10 | Lab 6: CodePipeline deploy lên ECS (Rolling update) | `sections/section_9/chapter_10.html` | Terraform stack (VPC, ALB 80/81, TG Blue/Green, ECS Fargate, `deployment_controller_type = ECS`), `imagedefinitions.json`, action Amazon ECS, quan sát rolling update, circuit breaker |
| 11 | Lab 7: Blue/Green deployment lên ECS với CodeDeploy | `sections/section_9/chapter_11.html` | Controller `CODE_DEPLOY`, role `AWSCodeDeployRoleForECS`, application `nodejs-ecs-app` + deployment group (listener 80/81, 2 TG, ECSAllAtOnce), `appspec.yaml` `<TASK_DEFINITION>`, `taskdef.json` `<IMAGE_NAME>`, `imageDetail.json`, test port 81, Reroute traffic, Terminate original task set |
| 12 | Lab 8: Canary deployment lên ECS với CodeDeploy | `sections/section_9/chapter_12.html` | Custom deployment config `ECSCanary25Percent5Minutes`, reroute immediately, ALB weighted forward 75/25, đo tỷ lệ bằng curl, Linear & rollback (tuỳ chọn) |
| 13 | Lab 9: Manual approval & notification trong CodePipeline | `sections/section_9/chapter_13.html` | Notification rule pipeline & CodeDeploy, SNS topic + email subscription, stage Approval (Manual approval) trước Deploy, Approve / Reject |
| 14 | Tổng kết section & dọn dẹp resource | `sections/section_9/chapter_14.html` | Tổng kết & lộ trình 9 lab, các file cấu hình (buildspec, imagedefinitions, imageDetail, taskdef, appspec), checklist dọn dẹp (Beanstalk, pipeline, CodeDeploy, terraform destroy, ECR, S3, log group), tài liệu tham khảo |

## Section 10. CI/CD sử dụng Jenkins
Nguồn: `slide_old/10.CICD_su_dung_Jenkins.pptx`, `source_code_old/10-cicd-using-jenkins/`
Source code lab: `sourcecode/section_10_cicd_with_jenkins/` (EC2 Ubuntu 24.04 `t3.medium` + IAM Role `jenkins-server-role`, Jenkins LTS + Java 21, Node.js 22, Docker Engine; repo mẫu `simple-java-maven-app`, `simple-vue-webpack`, `nodejs-random-color` (branch `master` + `develop`); Terraform stack `terraform_ecs_stack` dùng chung Lab 7 → Lab 10, không NAT Gateway)

| Chapter | Tên chapter | File | Nội dung chính |
|---|---|---|---|
| 1 | Giới thiệu Jenkins & CI/CD với Jenkins | `sections/section_10/chapter_1.html` | Mục tiêu section, Jenkins là gì, tại sao dùng nhiều, controller/agent/executor/job/build/workspace/plugin/credential, kiến trúc Jenkins trên EC2 + IAM Role, job CI/CD điển hình, trade-off vs CodePipeline/GitHub Actions, lộ trình 12 lab |
| 2 | Lab 1: Cài đặt Jenkins server trên EC2 (Ubuntu) | `sections/section_10/chapter_2.html` | IAM Role (S3, ECR, ECS), SG 22/8080 My IP, Ubuntu 24.04 `t3.medium` 30 GiB, Java 21, Jenkins LTS repo `debian-stable`, unlock + suggested plugins + admin, Git/jq/AWS CLI v2, `sudo -u jenkins aws sts get-caller-identity`, Manage Jenkins |
| 3 | Lab 2: Làm quen giao diện & tạo job Freestyle đầu tiên | `sections/section_10/chapter_3.html` | Dashboard, job `lab02-hello-job`, Execute shell (`sh -xe`), Console Output, workspace, build lỗi, Build periodically (`H/5`), discard old builds |
| 4 | Lab 3: Biến (Variable), Parameter & Credential trong Jenkins | `sections/section_10/chapter_4.html` | Built-in variable (`env-vars.html`), global env `COMPANY_NAME`, String/Choice/Boolean parameter, credential `dblogin` + binding, masking `****`, `withCredentials` |
| 5 | Jenkins Pipeline: Jenkinsfile, Declarative vs Scripted | `sections/section_10/chapter_5.html` | Pipeline as Code, job CI & job CD, cấu trúc Declarative (agent, options, tools, parameters, environment, stages, when, post), nháy đơn vs nháy kép, Scripted `node {}`, Freestyle vs Declarative vs Scripted, 4 phương án quản lý job |
| 6 | Lab 4: Build Java project (Maven) & upload artifact lên S3 | `sections/section_10/chapter_6.html` | Tools `JDK21` + `M3`, bucket `jenkins-artifact-<suffix>`, Freestyle (Git + Maven `clean package` + `aws s3 cp`), Declarative (Checkout/Build/Test/Upload, `junit`, `archiveArtifacts`) |
| 7 | Lab 5: Build Node.js (Vue + Webpack) & upload lên S3 | `sections/section_10/chapter_7.html` | NodeSource Node.js 22, `npm install` / `npm run build`, clear `dist`, `aws s3 sync --delete`, (tuỳ chọn) S3 static website + bucket policy |
| 8 | Lab 6: Build Docker image & push lên Amazon ECR | `sections/section_10/chapter_8.html` | Docker Engine từ repo chính thức, group `docker` + restart Jenkins, ECR `nodejs-random-color`, Dockerfile `node:22-alpine` (ECR Public), Account ID qua `sts`, tag `ver-<BUILD_NUMBER>`, `docker image prune` |
| 9 | Lab 7: Job deploy lên Amazon ECS (Terraform stack) | `sections/section_10/chapter_9.html` | Terraform stack (VPC 10.30.0.0/16, ALB, ECS Fargate, circuit breaker, `ignore_changes`), job `lab07-deploy-ecs` parameter `IMAGE_TAG`, `jq` + `register-task-definition` + `update-service --force-new-deployment` + `wait services-stable`, rolling update, rollback |
| 10 | Lab 8: Pipeline from SCM & private repository (SSH key) | `sections/section_10/chapter_10.html` | `ssh-keygen` ed25519, GitHub Deploy key (read-only), repo Private, Git Host Key Verification (Accept first connection), credential `github-ssh-key`, Jenkinsfile trong repo, Declarative: Checkout SCM |
| 11 | Lab 9: Tự động trigger job từ GitHub webhook | `sections/section_10/chapter_11.html` | Nhánh `develop`, `Jenkinsfile-auto` (build + push `ver-N` & `latest` + deploy), SG 8080 cho IP webhook GitHub (`api.github.com/meta`), GitHub hook trigger, webhook `/github-webhook/`, `disableConcurrentBuilds` |
| 12 | Lab 10: Job release theo Git tag & tham số ACTION | `sections/section_10/chapter_12.html` | Release thủ công, parameter `VERSION` + `ACTION` (BuildAndDeploy/OnlyBuild/OnlyDeploy), `checkout scmGit` `refs/tags/...`, `when { expression }`, tag v1.0.0/v1.0.1 trên master, rollback bằng OnlyDeploy |
| 13 | Lab 11: Scripted Pipeline | `sections/section_10/chapter_13.html` | Viết lại Lab 6 bằng `node {}`, biến Groovy, `if`/`for`, `withEnv`, `readFile`, try/catch/finally, `currentBuild.result`, khối `script {}` trong Declarative |
| 14 | Lab 12: Gửi notification kết quả job sang Slack | `sections/section_10/chapter_14.html` | Slack channel, Slack App từ manifest (bot token `xoxb-`), `/invite @Jenkins`, plugin Slack Notification, credential Secret text, `post { always { slackSend } }`, parameter `SIMULATE_FAILURE` |
| 15 | Tổng kết section & dọn dẹp resource | `sections/section_10/chapter_15.html` | Tổng kết & lộ trình, luồng branch/tag → Dev/Production, cheat sheet step Pipeline, checklist dọn dẹp (terraform destroy, task definition, ECR, S3, EC2 Jenkins, GitHub webhook/deploy key, Slack App), best practice vận hành Jenkins, tài liệu tham khảo |

## Section 11. Chiến lược deployment cho Database
Source code lab: `sourcecode/section_11_deployment_strategy/lab-rds-blue-green/` (Terraform dựa trên `infra/terraform` của repo `hoanglinhdigital/lab-expense-management`: VPC 3 tầng, ALB `:80`/`:8080`, ECS Fargate + CodeDeploy Blue/Green, RDS MySQL 8.0 → 8.4, CodePipeline/CodeBuild/ECR; thêm parameter group `pg-mysql80-01`/`pg-mysql84-01`, credential DB trong Secrets Manager (`random_password`, ECS `secrets` → `DATABASE_URL`), `db_active_parameter_group`, `lab_force_destroy`; script `check_downtime.sh`, `verify_queries.sql`; `ap-southeast-1`)

| Chapter | Tên chapter | File | Nội dung chính |
|---|---|---|---|
| 1 | Blue/Green cho database: Amazon RDS Blue/Green Deployments | `sections/section_11/chapter_1.html` | Green đồng bộ bằng logical replication, read-only, thay đổi tương thích vs không tương thích, quy trình Create → Modify → Test → Switchover → Clean up, guardrail, endpoint không đổi, `-old1`, chi phí |
| 2 | Lab: RDS Blue/Green Deployment kết hợp ECS Blue/Green | `sections/section_11/chapter_2.html` | Fork repo Expense Management, CodeConnections, `terraform apply`, credential DB trong Secrets Manager + ECS `secrets`/`valueFrom`, nâng cấp MySQL 8.0 → 8.4 + `db.t4g.small` + parameter group mới bằng RDS Blue/Green, kiểm tra replication/read-only bằng MySQL Workbench, switchover & đo downtime, release app v2 bằng CodeDeploy (test `:8080`, Reroute traffic, rollback), `terraform state rm` + `import` sau switchover, dọn dẹp |

## Section 12. Serverless Application Model (SAM)
Nguồn: `slide_old/12.Serverless_Application_Model(SAM).pptx`, `source_code_old/12-serverless-application-model/`
Source code lab: `sourcecode/section_12_serverless_application_model/` (Python 3.13, SAM CLI; stack `url-shorten-app` dùng chung Lab 2 → Lab 4; Lambda dùng biến môi trường `TABLE_NAME` + SAM policy templates thay cho `dynamodb:*`; Lab 4 thay template bằng `AutoPublishAlias` + `DeploymentPreference` Canary + CloudWatch Alarm; `ap-southeast-1`)

| Chapter | Tên chapter | File | Nội dung chính |
|---|---|---|---|
| 1 | Serverless và AWS SAM là gì? | `sections/section_12/chapter_1.html` | Mục tiêu section, serverless là gì, SAM = phần mở rộng CloudFormation (`Transform`), luồng code → S3 → CloudFormation → Lambda/API Gateway/DynamoDB, các resource `AWS::Serverless::*`, trade-off & so sánh SAM/CloudFormation/Terraform/CDK, chi phí & giới hạn Lambda |
| 2 | Cấu trúc template SAM & các lệnh SAM CLI | `sections/section_12/chapter_2.html` | `Transform`/`Globals`/`Resources`/`Events`/`Outputs`, cấu trúc thư mục dự án, `samconfig.toml`, policy templates, vòng đời `sam init → validate → build → local → deploy → logs → sync → delete`, bảng lệnh SAM CLI, resource ngầm định `ServerlessRestApi`, `CAPABILITY_IAM` |
| 3 | Lab 1: Cài đặt SAM CLI & ứng dụng Hello World | `sections/section_12/chapter_3.html` | Cài SAM CLI, kiểm tra Python 3.13/AWS CLI/Docker, `sam init` (hello-world), đọc `template.yaml`, `sam build`, `sam local invoke`/`start-api`, `sam deploy --guided`, xem stack/Lambda/API Gateway trên Console, sửa code deploy lại, `sam delete` |
| 4 | Lab 2: Triển khai ứng dụng URL Shortener bằng SAM | `sections/section_12/chapter_4.html` | Template API Gateway (stage `dev`) + 2 Lambda (`generate_short_url`, `get_url`) + DynamoDB `UrlShortenTable`, biến môi trường `TABLE_NAME` trong `Globals`, `DynamoDBWritePolicy`/`DynamoDBReadPolicy`, `sam deploy --guided`, tạo short URL bằng curl/Postman, redirect HTTP 308, kiểm tra Console |
| 5 | Lab 3: Test ở local, xem log & cập nhật nhanh với sam sync | `sections/section_12/chapter_5.html` | Unit test `pytest`, `env.json` ghi đè `TABLE_NAME`, `sam local invoke` với event mẫu, `sam local start-api`, `sam list endpoints`, `sam logs --tail`, `sam sync --watch` và lưu ý chỉ dùng cho dev |
| 6 | Lambda version, alias & Safe deployment với CodeDeploy | `sections/section_12/chapter_6.html` | Version/alias, `AutoPublishAlias`, `DeploymentPreference` (Canary, Linear, AllAtOnce), Alarms & Hooks (Pre/PostTraffic), sơ đồ weighted alias, trade-off, CodeDeploy tự tạo bởi SAM, CloudFormation chờ CodeDeploy, rollback |
| 7 | Lab 4: Canary deployment cho Lambda với SAM & CodeDeploy | `sections/section_12/chapter_7.html` | `GetUrlFunction` + `AutoPublishAlias: live` + `Canary10Percent5Minutes`, CloudWatch Alarm `Errors` theo `ExecutedVersion`, release v2 và đếm tỷ lệ v1/v2 qua header `X-App-Version`, release v3 lỗi → alarm → CodeDeploy rollback, xác nhận vẫn chạy v2 |
| 8 | Tổng kết section & dọn dẹp resource | `sections/section_12/chapter_8.html` | Tổng kết & lộ trình, cheat sheet lệnh SAM CLI, best practice, checklist dọn dẹp (`sam delete`, CloudWatch Log group, CodeDeploy, bucket managed `aws-sam-cli-managed-default-*`, local), tài liệu tham khảo |

## Section 13. Kubernetes (k8s) cơ bản
Nguồn: `slide_old/13.Kubernetes(k8s)-basic.pptx`, `source_code_old/13-kubernetes-basic/`
Source code lab: `sourcecode/section_13_kubernetes_k8s_basic/` (Docker Desktop, kubectl, Minikube cho Lab 1 → Lab 3; EC2 Ubuntu + AWS CLI + kops + domain Route53 cho Lab 4 → Lab 5; region `ap-southeast-1`)

| Chapter | Tên chapter | File | Nội dung chính |
|---|---|---|---|
| 1 | Container Orchestration & Giới thiệu Kubernetes | `sections/section_13/chapter_1.html` | Mục tiêu section, container orchestration là gì & các công việc đảm nhận, lịch sử Kubernetes (Borg → Omega → v1.0 → CNCF), vì sao phổ biến, trade-off, use cases |
| 2 | Kiến trúc Kubernetes cluster: Control Plane, Worker Node & kubectl | `sections/section_13/chapter_2.html` | Control Plane (API Server, etcd, Scheduler, Controller Manager), Worker node (kubelet, kube-proxy, container runtime), kubectl (imperative vs declarative), kube config, HA |
| 3 | Các khái niệm cơ bản & Pod | `sections/section_13/chapter_3.html` | Bản đồ khái niệm (Pod, ReplicaSet, Deployment, Service, Ingress, Namespace, ConfigMap, Secret, PV, StatefulSet), Pod (đơn vị nhỏ nhất, sidecar, share network/storage, ephemeral) |
| 4 | Lab 1: Cài đặt Minikube & chạy Pod đầu tiên | `sections/section_13/chapter_4.html` | Phần 1: cài kubectl, Minikube, `minikube start`, `kubectl get nodes`, troubleshoot context (`config get-contexts`/`use-context`), docker context; Phần 2: `kubectl run nginx-pod --image=nginx`, `get pods`/`-o wide`, `describe`, `delete pod`; Phần 3: manifest Pod YAML (apiVersion/kind/metadata/spec), `kubectl apply -f`, `delete -f` |
| 5 | Namespace trong Kubernetes | `sections/section_13/chapter_5.html` | Namespace là gì, use cases, resource KHÔNG thuộc namespace (Nodes, PV, ClusterRoles), thao tác create/set-context/`-n` |
| 6 | ReplicaSet: đảm bảo số lượng Pod | `sections/section_13/chapter_6.html` | ReplicationController vs ReplicaSet, `replicas`, selector & label, tự phục hồi; thực hành: ReplicaSet 5 Pod nginx, delete 1 Pod quan sát tự phục hồi (source `replica_set/`) |
| 7 | Deployment: update & rollback | `sections/section_13/chapter_7.html` | Deployment bọc ReplicaSet, chiến lược Recreate/RollingUpdate, maxSurge & maxUnavailable, lệnh create/get/update/rollout/undo; thực hành: Deployment 3 Pod RollingUpdate, update nginx:1.17.9 → 1.17.10, `scale --replicas=5`, `rollout history/undo/--to-revision` (source `deployment/`) |
| 8 | Service: NodePort, ClusterIP, LoadBalancer | `sections/section_13/chapter_8.html` | Service (IP/DNS ổn định, selector, load balancing), 3 loại Service, port/targetPort/nodePort, NodePort range 30000–32767 |
| 9 | Lab 2: Tạo NodePort Service | `sections/section_13/chapter_9.html` | Deployment + Service NodePort (nodePort 30099), `minikube service nginx-service --url`, truy cập trình duyệt |
| 10 | Lab 3: Tạo ClusterIP Service | `sections/section_13/chapter_10.html` | Service ClusterIP cho MongoDB (port 27017), lưu ý DB thật cần StatefulSet |
| 11 | Ingress: định tuyến HTTP/HTTPS | `sections/section_13/chapter_11.html` | Ingress rule theo host/path, Ingress Controller (nginx, traefik, istio...), LoadBalancer vs Ingress, ALB Ingress Controller; thực hành: build 2 image nodejs (Service-A/B) push DockerHub, Ingress theo host service-a/b.localhost, `minikube addons enable ingress`, `minikube tunnel` (source `ingress/`) |
| 12 | Persistent Volume & Storage Class | `sections/section_13/chapter_12.html` | PV/PVC/StorageClass, local vs remote volume, Kubernetes không quản lý disk, access mode; thực hành: PV hostPath + PVC + MySQL NodePort, insert data, delete pod, kiểm tra data còn (source `persistent_volume/`) |
| 13 | ConfigMap | `sections/section_13/chapter_13.html` | ConfigMap lưu cấu hình không nhạy cảm, 3 cách truyền vào (env, args, volume), `envFrom`/`configMapRef`; thực hành: ConfigMap `my-configmap`, MySQL dùng `envFrom.configMapRef`, kết nối bằng password trong ConfigMap (source `configmap/`) |
| 14 | Secret | `sections/section_13/chapter_14.html` | Secret lưu dữ liệu nhạy cảm, base64, `secretKeyRef`, lưu ý base64 ≠ mã hoá; thực hành: `echo -n | base64`, Secret username/password, MySQL dùng `secretKeyRef`, decode kiểm tra (source `secret/`) |
| 15 | StatefulSet | `sections/section_13/chapter_15.html` | Ứng dụng có state (MySQL master/worker), tên ổn định + storage riêng, rủi ro mất data, nên dùng dịch vụ cloud (RDS, ElastiCache); thực hành: headless Service + StatefulSet nginx 3 Pod, `volumeClaimTemplates` (PVC riêng mỗi Pod), DNS `web-0.nginx-headless`, xoá Pod giữ tên & data, scale theo thứ tự, PVC không tự xoá (source `stateful_set/`) |
| 16 | Lab 4: Tạo Kubernetes cluster bằng kops | `sections/section_13/chapter_16.html` | Giới thiệu kops (HA, idempotency, Terraform), cài AWS CLI/kubectl/kops trên EC2 Ubuntu, S3 state + Route53, `kops create/update/validate cluster`, kết nối từ máy local |
| 17 | Lab 5: Triển khai ứng dụng mẫu lên Kubernetes | `sections/section_13/chapter_17.html` | React + Express + MongoDB, chạy thử Docker Compose, build image push ECR, manifest + Ingress Nginx (`/api` → backend, `/` → frontend), ALB + Target Group |
| 18 | Tổng kết section & dọn dẹp resource | `sections/section_13/chapter_18.html` | Tổng kết & lộ trình 5 lab, cheat sheet lệnh kubectl, checklist dọn dẹp (minikube, kops delete cluster, ALB/TG/S3/EC2, NAT/EIP/EBS), tài liệu tham khảo |

## Section 14. Elastic Kubernetes Service (EKS)
Nguồn: `slide_old/14.Elastic_Kubernetes_Service(EKS).pptx`, `source_code_old/14-EKS-basic/`
Source code lab: `sourcecode/section_14_eks_basic/` (eksctl + kubectl + helm + AWS CLI; cluster `devops-test-cluster`, region `ap-southeast-1`; image ECR `devops-lab13-frontend`/`devops-lab13-backend` từ Section 13)

| Chapter | Tên chapter | File | Nội dung chính |
|---|---|---|---|
| 1 | Giới thiệu về Amazon EKS | `sections/section_14/chapter_1.html` | Mục tiêu section, EKS là gì (managed Kubernetes), các tính năng chính, mô hình cluster (control plane do AWS quản lý, worker EC2/Fargate), chi phí EKS, trade-off, use cases |
| 2 | Lab 1: Tạo một EKS Cluster và kết nối | `sections/section_14/chapter_2.html` | Kiểm tra tool (aws/kubectl/eksctl/helm), `eksctl create cluster -f cluster-config.yaml` (2 node t3.medium), disable extended support, `update-kubeconfig`, `kubectl get nodes` |
| 3 | LoadBalancer trong EKS | `sections/section_14/chapter_3.html` | NLB vs ALB, AWS Load Balancer Controller (IRSA), cơ chế tạo ALB/NLB từ Ingress/Service, so sánh ALB/NLB, trade-off, use cases |
| 4 | Lab 2: LoadBalancer trong EKS – Part 1 | `sections/section_14/chapter_4.html` | Tạo IAM policy + IRSA cho LB Controller, cài bằng Helm, deploy 2048 game (Namespace/Deployment/Service/Ingress), truy cập qua ALB |
| 5 | Lab 2: LoadBalancer trong EKS – Part 2 | `sections/section_14/chapter_5.html` | Deploy frontend/backend/mongo + Ingress ALB định tuyến `/api` → backend, `/` → frontend, truy cập qua ALB |
| 6 | Storage trong EKS | `sections/section_14/chapter_6.html` | Các loại storage (EBS, EFS, FSx, File Cache, Mount S3, CSI Snapshot), EBS CSI Driver, EBS vs EFS, trade-off, use cases |
| 7 | Lab 3: Volume trong EKS | `sections/section_14/chapter_7.html` | Cài EBS CSI Driver (IAM Role + add-on), StorageClass ebs-sc + PVC mongo-pvc, gắn EBS vào MongoDB, test persist data khi xoá Pod |
| 8 | Autoscaling cho EKS | `sections/section_14/chapter_8.html` | Cluster Autoscaler (ASG) vs Karpenter, HPA/VPA, so sánh 2 phương pháp, Karpenter concept, trade-off |
| 9 | Security for EKS | `sections/section_14/chapter_9.html` | IAM Role & Policy (IRSA), Secret Management (K8s Secret, Parameter Store, Secrets Manager), Pod Security (PSA), RBAC (Role/ClusterRole/RoleBinding/ClusterRoleBinding), Access Entry |
| 10 | Lab 4: Add new IAM User to EKS Cluster | `sections/section_14/chapter_10.html` | Tạo user developer01 (PowerUserAccess), gán Access Entry (AmazonEKSViewPolicy), cấu hình aws profile, update-kubeconfig, kiểm tra quyền, khôi phục kubeconfig Admin |
| 11 | Tổng kết & dọn dẹp resource | `sections/section_14/chapter_11.html` | Tổng kết & lộ trình 4 lab, cheat sheet lệnh, checklist dọn dẹp (eksctl delete cluster, ALB/NLB, EBS, IAM user/policy, ECR), chủ đề nên học thêm |

## Section 15. Monitoring for Kubernetes/EKS
Nguồn: `slide_old/15.Monitoring_for_EKS.pptx`, `source_code_old/15-monitoring-for-kubernetes-eks/`
Source code lab: `sourcecode/section_15_monitoring_for_eks/` (Minikube local; app TODO `react-express-mongodb`; namespace `monitoring`; Prometheus/Grafana/AlertManager, ELK+Filebeat, OpenTelemetry+Jaeger)

| Chapter | Tên chapter | File | Nội dung chính |
|---|---|---|---|
| 1 | Các yếu tố cần quan tâm khi giám sát hạ tầng & ứng dụng trên K8s/EKS | `sections/section_15/chapter_1.html` | 3 trụ cột Observability (Metrics/Logging/Tracing), 2 phạm vi giám sát (Infrastructure vs Application: Node Health, CPU/Memory, Disk, Pod Metrics, App Log, API Error/Latency, Service Mesh, Resource Provisioning), vì sao K8s khó giám sát |
| 2 | Các giải pháp Open Source cho Monitoring | `sections/section_15/chapter_2.html` | Hệ sinh thái CNCF, bảng phân loại tool theo mục đích, Prometheus+Grafana (Node Exporter, pull/scrape), ELK stack (Filebeat/Logstash/Elasticsearch/Kibana), trade-off, use cases |
| 3 | Giải pháp Managed Service cho Monitoring EKS | `sections/section_15/chapter_3.html` | Bảng dịch vụ AWS theo mục đích, CloudWatch (Metrics/Logs/Container Insights/Alarm), Amazon Managed Prometheus (AMP) + Managed Grafana (AMG), AWS X-Ray, ADOT Collector, trade-off |
| 4 | Giải pháp SaaS cho Monitoring EKS | `sections/section_15/chapter_4.html` | Bảng phân loại SaaS, NewRelic (kiến trúc + dashboard), DataDog (kiến trúc + dashboard), trade-off (chi phí, vendor lock-in), use cases |
| 5 | Lab 1: Monitoring for Kubernetes – Metrics and Alert | `sections/section_15/chapter_5.html` | Deploy TODO app + mongo-exporter, Prometheus/Grafana/AlertManager, PromQL query, Grafana dashboard, alert-rules (5 alert), Slack notification, test alert (scale backend về 0) |
| 6 | Lab 2: Monitoring for Kubernetes – Log | `sections/section_15/chapter_6.html` | ELK + Filebeat (`log-collection.yaml`), verify pods, truy cập Kibana, tạo index pattern `todo-app-logs-*`, xem log qua Discover |
| 7 | Lab 3: Monitoring for Kubernetes – Request Tracing | `sections/section_15/chapter_7.html` | Giới thiệu OpenTelemetry & Jaeger, cài cert-manager/Jaeger/OTel Operator, `tracing.yaml` (Jaeger All-in-one + Instrumentation + Collector), annotation auto-instrument, rollout, xem trace trên Jaeger UI |
| 8 | Tổng kết | `sections/section_15/chapter_8.html` | 3 trụ cột Observability, mô hình giám sát tổng quát, 3 nhóm giải pháp (Open Source/Managed/SaaS), tổng hợp 3 lab, lưu ý quan trọng (chọn đúng tool, MTTR, PII) |

## Section 16. CICD for Kubernetes/EKS
Nguồn: `slide_old/16.CICD_for_EKS.pptx`, `source_code_old/16-cicd-for-kubernetes-eks/`
Source code lab: `sourcecode/section_16_cicd_for_eks/` (cluster `devops-test-cluster`, region `ap-southeast-1`; app monorepo `react-express-mongodb` (React + Express + MongoDB); eksctl + kubectl + helm + AWS CLI; CodePipeline, GitHub Actions, ArgoCD)

| Chapter | Tên chapter | File | Nội dung chính |
|---|---|---|---|
| 1 | Tổng quan flow CI-CD cho Kubernetes/EKS | `sections/section_16/chapter_1.html` | Luồng CI/CD cho K8s (Source → Build image → ECR → kubectl apply → EKS), các giai đoạn, so sánh deploy truyền thống (EC2) vs Kubernetes (image immutable, manifest, rollback), nguyên tắc, trade-off, use cases |
| 2 | Các phương án implement CICD cho Kubernetes/EKS | `sections/section_16/chapter_2.html` | Các phương án (Jenkins+Helm, CodePipeline, ArgoCD/GitOps, Terraform/CDK8s), bảng so sánh công cụ CI (Jenkins/GitHub Actions/GitLab CI/CodePipeline), tiêu chí chọn, trade-off, use cases |
| 3 | Lab 1: Tạo một EKS Cluster và kết nối | `sections/section_16/chapter_3.html` | eksctl tạo cluster + node group (2 x t3.medium), disable extended support, update-kubeconfig, cài OIDC + AWS Load Balancer Controller (IRSA + Helm) + deploy 2048 game qua ALB, cài EBS CSI Driver, xoá 2048 |
| 4 | Lab 2: Implement CICD using CodePipeline | `sections/section_16/chapter_4.html` | CodeCommit repo `todo-app-monorepo` (Full clone), 2 ECR repo, CodePipeline (Source→Build `buildspec.yml`→Deploy `Amazon EKS` kubectl `aws-eks.yaml`, private subnet), IAM policy + access entry, trigger CICD, cải thiện thực tế (tách pipeline, VERSION, manual approve, notification) |
| 5 | Lab 3: Implement CICD using GithubAction | `sections/section_16/chapter_5.html` | GitHub repo, GitHub Secrets (AWS credentials), workflow `.github/workflows/deploy.yml` (paths-filter, configure-aws-credentials, amazon-ecr-login, build+push ECR + sed tag, kubectl apply), trigger khi push, validate |
| 6 | Giới thiệu GitOps | `sections/section_16/chapter_6.html` | GitOps (Git = Single Source of Truth), 3 bước (khai báo → so sánh → đồng bộ), lợi ích (minh bạch, rollback, nhất quán, bảo mật), thành phần (VCS/Orchestrator/ArgoCD+Flux/Helm+Kustomize+Terraform), Push-based vs Pull-based, trade-off, use cases |
| 7 | Lab 4: Implement GitOps với GithubAction + ArgoCD | `sections/section_16/chapter_7.html` | Cài ArgoCD (namespace, install.yaml, port-forward, mật khẩu admin), ArgoCD Application + connect repo (PAT), deploy.yml mới (workflow_dispatch + input version + tag image), build/push ECR, tách manifest repo (`k8s-manifests`), sync ArgoCD, validate |

## Section 17. CI/CD sử dụng GitHub Actions
Nguồn: `slide_old/17.CICD_su_dung_GithubAction.pptx`, `source_code_old/17-github-action/`
Source code lab: `sourcecode/section_17_cicd_using_github_action/` (repository `nodejs-random-color` fork từ `hoanglinhdigital/nodejs-random-color`, nhánh `master` + `develop`; IAM User `PowerUserAccess` + Access Key lưu GitHub Secrets; Terraform stack Blue/Green `udemy-devops-cluster-blue`/`green`, ALB `udemy-devops-alb` listener `:80`/`:81`, không NAT Gateway)

| Chapter | Tên chapter | File | Nội dung chính |
|---|---|---|---|
| 1 | GitHub Actions là gì? | `sections/section_17/chapter_1.html` | GitHub Actions là gì, 6 khái niệm (workflow, event, job, step, action, runner), cấu trúc file workflow YAML, đặc điểm chính, mô hình hoạt động, pricing, trade-off, use cases, so sánh CodePipeline/Jenkins |
| 2 | Lab: Sử dụng GitHub Actions để implement Blue-Green deployment | `sections/section_17/chapter_2.html` | Chuỗi 6 lab: (1) build Docker image & push ECR (push `latest` + thủ công theo tag), (2) Terraform stack + deploy lên ECS cluster idle, (3) switch traffic trên ALB, (4) clear old resource (scale về 0), (5) pipeline tổng thể + manual approval (`workflow_call`, `environment`), (6) test khi push/PR vào `develop` |
| 3 | Tổng kết & Clear resources | `sections/section_17/chapter_3.html` | Tổng kết & lộ trình 6 lab, so sánh GitHub Actions vs Jenkins vs CodePipeline, checklist dọn dẹp (terraform destroy, task definition, ECR, IAM User, GitHub Secrets/Environment), best practice, tài liệu tham khảo |

## Section 18. Final Assignment
Nguồn: `slide_old/18.Final_Assignment_-_Container_Architect-Question.pptx`, `slide_old/18.Final_Assignment_-_Container_Architect-Sample_answer.pptx`
Source code tham khảo: `sourcecode/section_18_final_assignment/` (app `react-spring-mongo-full-stack-demo` React + Spring Boot + MongoDB; Terraform module network/security/storage/database/application; Dockerfile frontend/backend; CICD Jenkins + CodePipeline)

| Chapter | Tên chapter | File | Nội dung chính |
|---|---|---|---|
| 1 | Final assignment: Đề bài | `sections/section_18/chapter_1.html` | Giới thiệu final assignment, mục đích (5 mục), đề bài (repo `react-spring-mongo-full-stack-demo`, thiết kế Network/Security/Resources, triển khai AWS, CI/CD Jenkins/CodePipeline, capture kết quả), cấu trúc bài nộp, tiêu chí đánh giá, yêu cầu trước khi bắt đầu |
| 2 | Final assignment: Đáp án mẫu phần thiết kế | `sections/section_18/chapter_2.html` | Đáp án mẫu thiết kế: Networking (multi-AZ, public/private subnet, NAT), Security (SG chaining, least privilege, bastion), Services & Resources (VPC/ALB/ECS Fargate/ECR/EC2 MongoDB/CloudWatch), CI/CD Jenkins & CodePipeline, Terraform structure (5 module) |
| 3 | Final assignment: Hướng dẫn phần triển khai lên AWS | `sections/section_18/chapter_3.html` | Lab triển khai: clone repo, build Docker image, tạo ECR + push image, deploy Terraform (init/plan/apply), kiểm tra qua ALB, triển khai CI/CD (Jenkins/CodePipeline), trigger pipeline; troubleshoot (CannotPullContainerError, MongoDB kết nối, health check, listener rule); dọn dẹp terraform destroy |
