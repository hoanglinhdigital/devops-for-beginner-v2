# Lab 1: Tạo một EKS Cluster và kết nối tới nó.

#========== Phương án sử dụng AWS Console ==========
# Tham khảo guide chính thức:
# https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html

#========== Phương án sử dụng EKSCTL ==========
# Guide gốc của AWS:
# https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html

# Yêu cầu máy đã cài sẵn các tool:
#  - aws cli   (chú ý không dùng version quá cũ)
#  - kubectl   https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/
#  - eksctl    https://eksctl.io/installation/
#  - helm      https://helm.sh/docs/intro/install/
# NOTE: nên dùng chocolatey để cài eksctl, kubectl, helm cho Windows.

# Kiểm tra version
aws --version
kubectl version --client
eksctl version
helm version --short

#=== Step 1: Kiểm tra IAM user đã có quyền tạo EKS Cluster ===
aws sts get-caller-identity

#=== Step 2: Tạo EKS Cluster (mất ~10 phút) ===
# Chỉnh sửa cluster-config.yaml nếu muốn đổi tên cluster, region, số node, instance type...
eksctl create cluster -f cluster-config.yaml

# Disable extended support cho EKS (giúp tiết kiệm chi phí):
aws eks update-cluster-config --name devops-test-cluster --upgrade-policy supportType=STANDARD

#=== Step 3: Cập nhật kubeconfig (Windows: C:\Users\{username}\.kube\config) ===
aws eks update-kubeconfig --region ap-southeast-1 --name devops-test-cluster

# Kiểm tra context
kubectl config get-contexts
# [Optional] chuyển context nếu có nhiều cluster
kubectl config use-context devops-test-cluster

# Xem thông tin cluster
kubectl cluster-info
# Kết quả mong đợi:
#   Kubernetes control plane is running at https://<id>.gr7.ap-southeast-1.eks.amazonaws.com
#   CoreDNS is running at https://<id>.gr7.ap-southeast-1.eks.amazonaws.com/api/v1/

#=== Step 4: (Tuỳ chọn) Tạo node group gồm 2 node t3.medium ===
# BỎ QUA bước này nếu đã tạo cluster có node group ở trên.
eksctl create nodegroup --cluster=devops-test-cluster --region=ap-southeast-1 --name=my-node-group --node-type=t3.medium --nodes=2 --nodes-min=2 --nodes-max=2 --managed

#=== Step 5: Đợi ~5 phút rồi kiểm tra node ===
kubectl get nodes

# Kết thúc: bạn đã tạo thành công một EKS Cluster và kết nối được tới nó.
