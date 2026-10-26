# Lab 3: Implement CICD sử dụng GitHub Actions (build + push ECR + deploy EKS).

# Repository ứng dụng (monorepo frontend + backend + MongoDB):
# https://github.com/hoanglinhdigital/react-express-mongodb

#==== Step 1: Source Control với GitHub =====
# Tạo repository trên GitHub (vd: todo-app-monorepo), sau đó push code lên:
git add .
git commit -m "Initial commit for EKS deployment via GitHub Actions"
git push -u origin master

#==== Step 2: Tạo Amazon ECR Repositories (skip nếu đã làm ở Lab 2) =====
# Tạo 2 private repo trên ECR Console:
#   - todo-app-frontend
#   - todo-app-backend

#==== Step 3: Cấu hình GitHub Secrets =====
# Vào GitHub repo -> Settings -> Secrets and variables -> Actions -> New repository secret:
#   AWS_ACCESS_KEY_ID      : Access key của IAM user
#   AWS_SECRET_ACCESS_KEY  : Secret key của IAM user
#   AWS_REGION             : ap-southeast-1
#   EKS_CLUSTER_NAME       : devops-test-cluster
# (Khuyến nghị dùng IAM Role + OIDC thay vì access key dài hạn để bảo mật hơn)

#==== Step 4: Tạo GitHub Actions Workflow =====
# Tạo file .github/workflows/deploy.yml với nội dung ở file deploy.yml kèm theo.

#==== Step 5: Trigger CI/CD Pipeline =====
git add .
git commit -m "Update application and workflow"
git push origin master

# Vào tab "Actions" trên GitHub repo để xem workflow "Deploy to EKS" chạy.

#==== Step 6: Validate kết quả =====
# Cập nhật local kubeconfig nếu chưa có:
aws eks update-kubeconfig --name devops-test-cluster --region ap-southeast-1

kubectl get deployments
kubectl get pods
kubectl describe pod <pod-name>
kubectl get svc
kubectl get ingress
# Đợi ALB provision, truy cập ứng dụng qua Ingress Address hoặc LoadBalancer URL
