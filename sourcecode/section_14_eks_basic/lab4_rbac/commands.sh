# Lab 4: Add new IAM User to EKS Cluster (RBAC)
# Yêu cầu: tạo user "developer01" mới và gán quyền vào Cluster EKS.

#=== Step 1: Tạo user developer01 ===
# - Quyền: PowerUserAccess
# - Tạo sẵn một AccessKey cho user developer01
# - Thử login AWS Console bằng id/pw của developer01, tìm đến cluster -> không thấy resource
#   (permission denied) vì chưa được cấp quyền trên EKS.

#=== Step 2: Gán quyền cho user developer01 (quay lại giao diện user Admin) ===
# Truy cập EKS Cluster -> tab "Access" -> khu vực "IAM access entries":
#  - Nhấn "Create access entry"
#  - IAM principal ARN: dán ARN của user developer01
#      ví dụ: arn:aws:iam::123456789012:user/developer01
#  - Type: Standard
#  - Nhấn Next
#  - Add access policy: chọn AmazonEKSViewPolicy, Access scope = Cluster -> Add policy
#  - Review rồi nhấn Create

#=== Step 3: Cấu hình aws cli để dùng user developer01 ===
aws configure --profile developer01
# Nội dung file ~/.aws/credentials tương ứng:
#   [developer01]
#   aws_access_key_id = AAAAAAAAAAAAAAA
#   aws_secret_access_key = bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb

# Kiểm tra profile:
aws sts get-caller-identity --profile developer01
# Kết quả mong đợi:
# {
#     "UserId": "AIDAWIVVHVPNJTU7GKK72",
#     "Account": "123456789012",
#     "Arn": "arn:aws:iam::123456789012:user/developer01"
# }

#=== Step 4: Sử dụng eksctl để cập nhật kubeconfig cho developer01 ===
# Xoá (hoặc backup) file kubeconfig hiện tại:
#   Windows: C:\Users\<user_name>\.kube\config
#   Linux/MacOS: ~/.kube/config
aws eks update-kubeconfig --region ap-southeast-1 --name devops-test-cluster --profile developer01

# Kiểm tra context
kubectl config get-contexts
kubectl cluster-info

# Kiểm tra quyền của developer01
kubectl get pods
kubectl get all -A
# Kết quả: xem được các resource trong cluster (vì đã gán AmazonEKSViewPolicy).
# [Optional] Quay lại console, truy cập EKS Cluster xem có thấy resource không.

#=== Step 5: Xoá user developer01 (truy cập vào IAM) ===

#=== Step 6: Khôi phục EKS config cho user Admin ===
aws sts get-caller-identity
# Kết quả hiện ra user Admin, ví dụ:
# {
#     "UserId": "AIDAWIVVHVPNJTU7GKK72",
#     "Account": "123456789012",
#     "Arn": "arn:aws:iam::123456789012:user/linhnguyen.admin"
# }

# Cập nhật lại config cho user Admin
aws eks update-kubeconfig --region ap-southeast-1 --name devops-test-cluster

# Kiểm tra context
kubectl config get-contexts
kubectl get all -A

#=== Step 7: Xoá EKS Cluster ===
eksctl delete cluster --name devops-test-cluster --region ap-southeast-1
