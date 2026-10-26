# Yêu cầu: AWS CLI v2 đã cấu hình profile, Terraform >= 1.6
# (xem lại Section 5 – Lab 1 để cài Terraform và AWS CLI)

# 1. Copy file biến mẫu và điền thông tin của bạn
cp terraform.tfvars.example terraform.tfvars
# Sửa `key_name`, và các giá trị khác trong terraform.tfvars cho khớp với tài khoản của bạn

# 2. Khởi tạo và xem trước thay đổi
terraform init
terraform plan --var-file "terraform.tfvars"

# 3. Triển khai
terraform apply --var-file "terraform.tfvars"

# 4. Xem thông tin cần thiết
terraform output

# 5. Truy cập ứng dụng qua DNS của ALB (output alb_dns_name)
#    curl http://<alb_dns_name>

# 6. Xoá toàn bộ resource khi học xong (quan trọng để tránh phát sinh chi phí)
terraform destroy --var-file "terraform.tfvars"
