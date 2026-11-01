# Lab: RDS Blue/Green Deployment kết hợp ECS Blue/Green

Giáo trình: `sections/section_11/chapter_2.html`

Ứng dụng: fork từ https://github.com/hoanglinhdigital/lab-expense-management (nhánh `master`).
Terraform trong thư mục này dựa trên `infra/terraform` của repo trên, bổ sung cho bài lab:

- `modules/database`: 2 parameter group `pg-mysql80-01` (Blue) và `pg-mysql84-01` (Green, bật `slow_query_log`), biến `active_parameter_group`.
- `modules/database`: `random_password` sinh master password + secret Secrets Manager `expense-mgmt/dev/rds-mysql-01` (key `username`, `password`, `host`, `port`, `dbname`, `DATABASE_URL`). Không còn biến `db_password`.
- `modules/compute`: Task Definition đọc `DATABASE_URL` qua `secrets` (`valueFrom = <secret-arn>:DATABASE_URL::`); execution role có inline policy `secretsmanager:GetSecretValue` trên đúng secret này.
- `modules/storage`: `force_delete` cho ECR repository.
- `modules/cicd`: thêm quyền `codeconnections:UseConnection` (connection tạo mới có ARN `arn:aws:codeconnections:...`).
- `environments/dev`: region `ap-southeast-1`, biến `db_active_parameter_group`, `lab_force_destroy`, output `alb_test_url`, `rds_identifier`, `rds_parameter_group_green`, `db_secret_name`.

```
terraform/environments/dev   # chạy terraform init / plan / apply / destroy tại đây
scripts/check_downtime.sh    # bash check_downtime.sh <ALB_DNS_NAME>
scripts/verify_queries.sql   # mở trong MySQL Workbench
```

Sau khi switchover RDS trên Console, đồng bộ lại state trước khi chạy `terraform apply`:

```
terraform state rm module.database.aws_db_instance.this
terraform import module.database.aws_db_instance.this expense-mgmt-dev-rds-mysql-01
```

rồi đổi `db_engine_version = "8.4"`, `db_instance_class = "db.t4g.small"`, `db_active_parameter_group = "mysql84"` trong `terraform.tfvars`.
