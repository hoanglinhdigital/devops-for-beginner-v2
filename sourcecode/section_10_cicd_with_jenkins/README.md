# Section 10 – CI/CD sử dụng Jenkins

Source code cho các bài lab của Section 10. Nội dung hướng dẫn: `sections/section_10/`.

Jenkins server chạy trên **EC2 Ubuntu Server 24.04 LTS** (`t3.medium`, 30 GiB gp3), Jenkins LTS + Java 21,
IAM Role `jenkins-server-role` (không dùng access key). Các lab sử dụng 3 repository mẫu trên GitHub
(học viên **fork** về account của mình):

| Repository | Branch | Dùng cho |
|---|---|---|
| `hoanglinhdigital/simple-java-maven-app` | `master` | Lab 4 (Maven, artifact `my-app-1.0-SNAPSHOT.jar`) |
| `hoanglinhdigital/simple-vue-webpack` | `master` | Lab 5 (Vue 3 + Webpack 5, build ra thư mục `dist`) |
| `hoanglinhdigital/nodejs-random-color` | `master`, `develop` | Lab 6 → Lab 12 (Express, port 3000) |

Các file `Jenkinsfile*` được **dán vào ô Pipeline script** của job (Lab 4 → 7, 10 → 12) hoặc **copy vào thư mục gốc của
repository** rồi commit & push (Lab 8, Lab 9 – Pipeline script from SCM). Các file `commands.sh` / `*.sh` là **tập hợp lệnh
tham khảo** theo thứ tự các bước, không chạy cả file một lần — copy từng lệnh và chạy trong Terminal.

| Folder | Bài lab |
|---|---|
| `lab1_install_jenkins/` | Lab 1 – Cài Java 21, Jenkins LTS, Git, jq, AWS CLI v2 trên EC2 Ubuntu |
| `lab2_first_job/` | Lab 2 – Job Freestyle đầu tiên `lab02-hello-job` |
| `lab3_variables_credentials/` | Lab 3 – Built-in variable, global variable, parameter, credential binding |
| `lab4_build_java/` | Lab 4 – Build Java (Maven `M3`, JDK `JDK21`), upload `.jar` lên S3 – Freestyle & Declarative |
| `lab5_build_nodejs/` | Lab 5 – Cài Node.js 22, build Vue + Webpack, `aws s3 sync` thư mục `dist` |
| `lab6_docker_ecr/` | Lab 6 – Cài Docker Engine, build image (`Dockerfile` base ECR Public `node:22-alpine`), push ECR |
| `lab7_deploy_ecs/` | Lab 7 – Job deploy ECS (parameter `IMAGE_TAG`, register task definition + `update-service`) |
| `lab8_pipeline_from_scm/` | Lab 8 – Private repository, SSH Deploy key, Pipeline script from SCM |
| `lab9_github_webhook/` | Lab 9 – GitHub webhook → nhánh `develop` → build + push + deploy tự động (`Jenkinsfile-auto`) |
| `lab10_release_by_tag/` | Lab 10 – Release thủ công theo Git tag trên `master`, `ACTION` = BuildAndDeploy / OnlyBuild / OnlyDeploy |
| `lab11_scripted_pipeline/` | Lab 11 – Viết lại Lab 6 bằng Scripted Pipeline (`node {}`, try/catch/finally) |
| `lab12_slack_notification/` | Lab 12 – Slack App (manifest) + plugin Slack Notification, `post { always { slackSend } }` |
| `terraform_ecs_stack/` | Terraform stack dùng chung cho Lab 7 → Lab 10: VPC, ALB, ECS Fargate |

## Terraform stack (`terraform_ecs_stack/`)
- Terraform >= 1.10, AWS provider `~> 6.0`, module `terraform-aws-modules/vpc/aws ~> 6.0`.
- Copy `terraform.tfvars.example` thành `terraform.tfvars` (đã gitignore) và điền `ecr_image_uri` (image tag đã push ở Lab 6).
- Tên resource (dùng trong Jenkinsfile): cluster `jenkins-lab-cluster`, service `nodejs-service`,
  task definition family `jenkins-lab-nodejs-task`, container `nodejs-container`.
- Để tiết kiệm chi phí: chỉ dùng public subnet + public IP cho task, **không** tạo NAT Gateway.
  Môi trường production nên đặt task ở private subnet (NAT Gateway hoặc VPC Endpoint).
- Service có `lifecycle { ignore_changes = [task_definition] }` để `terraform apply` không ghi đè version do Jenkins deploy.

## Lưu ý
- Không hard-code AWS Account ID: Jenkinsfile lấy Account ID bằng `aws sts get-caller-identity`.
- Không hard-code secret trong Jenkinsfile: dùng Jenkins Credentials (`dblogin`, `github-ssh-key`, Slack bot token).
- Thay các placeholder `<your-github-username>`, `<your-suffix>` trước khi chạy job.
- Chi phí: EC2 Jenkins (`t3.medium`) + Public IPv4 + ALB + task Fargate tính phí theo giờ.
  Stop Jenkins server khi không học, chạy `terraform destroy` sau Lab 10.
- So với phiên bản cũ: Ubuntu 24.04 + Java 21 (thay Java 17/19), Node.js 22 (thay 18), Docker Engine từ repository chính thức,
  AWS CLI v2 (Ubuntu 24.04 không còn package `awscli`), không hard-code Account ID, deploy bằng `jq` chọn container theo tên
  + `aws ecs wait services-stable`, GitHub **Deploy key** thay cho SSH key của cả account, Slack App bằng manifest
  (app "Jenkins CI" cũ đã ngừng hỗ trợ), Terraform stack không NAT Gateway.
