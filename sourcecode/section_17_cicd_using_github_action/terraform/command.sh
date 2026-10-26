# Yêu cầu: AWS CLI v2 đã cấu hình profile, Terraform >= 1.5
# (xem lại Section 5 – Lab 1 để cài Terraform và AWS CLI)

# 1. Copy file biến mẫu và điền thông tin của bạn
cp terraform.tfvars.example terraform.tfvars
# Sửa `ecr_image_uri` trong terraform.tfvars thành image ECR của bạn
# (đã build & push ở Lab 1, ví dụ 123456789012.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-random-color:v1.0.0)

# 2. Khởi tạo và triển khai
terraform init
terraform plan --var-file "terraform.tfvars"
terraform apply --var-file "terraform.tfvars"

# 3. Xem thông tin ALB (dns, arn, tên)
terraform output

# 4. Xoá toàn bộ resource khi học xong
terraform destroy --var-file "terraform.tfvars"
