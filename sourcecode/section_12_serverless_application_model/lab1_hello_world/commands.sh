# Lab 1 – Cài đặt SAM CLI & ứng dụng Hello World
# Tập hợp lệnh tham khảo theo thứ tự các bước – copy từng lệnh, không chạy cả file một lần.

# Kiểm tra công cụ
python --version
aws --version
sam --version
docker --version
aws sts get-caller-identity

# Tạo project mẫu (thư mục sam-app)
sam init --name sam-app --runtime python3.13 --app-template hello-world --package-type Zip --dependency-manager pip

cd sam-app
sam validate --lint
sam build

# Chạy thử ở local (cần Docker)
sam local invoke HelloWorldFunction --event events/event.json
sam local start-api

# Deploy lên AWS
sam deploy --guided

# Xoá stack
sam delete --stack-name sam-app
