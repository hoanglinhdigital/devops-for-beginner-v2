# Lab 4: Implement GitOps với GitHub Actions + ArgoCD.

# GitOps sử dụng "Single Source of Truth" là Git. Do đó:
#  - GitHub Actions KHÔNG deploy trực tiếp lên EKS nữa.
#  - GitHub Actions chỉ build + push Docker image lên ECR (CI).
#  - ArgoCD tự động deploy từ Git repository (manifest repo) xuống EKS (CD).

# Chuẩn bị:
#  - 1 GitHub repo chứa code application (FE/BE) + file .github/workflows/deploy.yml (tái sử dụng Lab 3).
#  - 1 GitHub repo chứa manifest aws-eks.yaml (gọi là Manifest repository - tạo mới).
#    Ví dụ tên repo: todo-app-demo-gitops-manifests

#==== Step 1: Cài đặt ArgoCD =====

# Tạo namespace argocd
kubectl create namespace argocd

# Cài ArgoCD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Truy cập ArgoCD UI (local port-forward)
kubectl port-forward svc/argocd-server -n argocd 8080:443
# Truy cập: https://localhost:8080 (username: admin)

# Lấy mật khẩu admin ban đầu
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

#==== Step 2: Tạo ArgoCD Application =====
# Sửa repoURL trong argocd-app.yaml thành URL manifest repo của bạn, sau đó apply:
kubectl apply -f argocd-app.yaml

#==== Step 3: Cấu hình credential cho ArgoCD truy cập GitHub repo (dùng GUI) =====
# Settings (biểu tượng bánh răng) -> Repositories -> + Connect Repo -> Via HTTPS:
#   Type: git
#   Repository URL: https://github.com/<username>/todo-app-demo-gitops-manifests.git (nên có đuôi .git)
#   Username: tên đăng nhập GitHub
#   Password: Personal Access Token (PAT) (KHÔNG phải mật khẩu đăng nhập GitHub)

#==== Step 4: Chuẩn bị file deploy.yml mới cho repo code application =====
# Tham khảo file deploy.yml kèm theo. Những thay đổi so với Lab 3:
#   - Chuyển trigger từ auto (push) sang manual (workflow_dispatch).
#   - Thêm input version để deploy version cụ thể.
#   - Dùng tag Docker image thay vì sha của commit.
#   - Bỏ bước kubectl apply -f aws-eks.yaml (ArgoCD lo việc này).

#==== Step 5: Test luồng CI/CD =====
# 1) Sửa code Backend & Frontend.
# 2) Commit, tag và push code lên Git:
git add .
git commit -m "Update version v1.0.4 to adapt with ArgoCD"
git tag v1.0.4
git push origin v1.0.4

# 3) Chạy GitHub Actions workflow:
#    GitHub repo -> Actions -> deploy.yml -> Run workflow -> nhập version -> Run workflow.
#    Chờ workflow hoàn thành, kiểm tra Docker image đã push lên ECR (backend & frontend).

# 4) Trong manifest repository:
#    - Tạo thư mục k8s-manifests, copy aws-eks.yaml vào đó.
#    - Sửa version muốn deploy cho backend & frontend trong aws-eks.yaml (vd: v1.0.4).
#    - Commit và push manifest repo.

# 5) Vào ArgoCD UI và sync application:
kubectl port-forward svc/argocd-server -n argocd 8080:443
# Truy cập https://localhost:8080, chọn application, bấm Sync để ArgoCD deploy.

#==== Step 6: Kiểm tra kết quả =====
kubectl get pods -n default
# Truy cập ứng dụng TODO và kiểm tra code mới đã được phản ánh.
