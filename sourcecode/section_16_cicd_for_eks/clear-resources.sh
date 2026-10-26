# Clear resources cho toàn bộ Section 16 — CICD for Kubernetes/EKS.

# 1) Xoá EKS Cluster (tự động xoá node group, VPC resources do eksctl tạo)
#    Chạy lệnh xoá node group trước nếu cần (thay tên node group cho đúng):
eksctl delete nodegroup --cluster devops-test-cluster --name my-nodes --drain=false

#    Sau đó xoá cluster:
eksctl delete cluster --name devops-test-cluster --force --disable-nodegroup-eviction

# 2) Xoá ECR Repository nếu không dùng nữa
aws ecr delete-repository --repository-name todo-app-frontend --force --region ap-southeast-1
aws ecr delete-repository --repository-name todo-app-backend --force --region ap-southeast-1

# 3) Xoá CodePipeline, CodeBuild project, CodeCommit repository (nếu đã tạo ở Lab 2)
#    - Xoá trên AWS Console (CodePipeline/CodeBuild/CodeCommit).

# 4) Xoá GitHub Secrets / IAM Access Key (nếu đã tạo ở Lab 3)
#    - Xoá secret trong GitHub repo và access key của IAM user.

# 5) Xoá Application Load Balancer nếu còn sót lại (thường bị xoá theo cluster).

# 6) Xoá EC2 instance (nếu còn).

# Lưu ý: CodePipeline + GitHub Actions có thể giữ lại để tham khảo trong tương lai.
