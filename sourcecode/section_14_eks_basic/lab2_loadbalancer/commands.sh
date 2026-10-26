# Lab 2: LoadBalancer trong EKS (ALB Ingress Controller)
# YÊU CẦU:
#  - Đã tạo thành công cluster ở Lab 1.
#  - Đã cài đặt eksctl, kubectl, aws cli, helm.

#==================== PART 1: Triển khai ứng dụng mẫu 2048 game ====================

#=== Step 1: Tạo IAM Policy cho AWS Load Balancer Controller ===
# Tạo policy từ file iam_policy.json (hoặc dùng policy có sẵn của AWS).
aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://iam_policy.json

#=== Step 2: Tạo IAM Role + Service Account cho Load Balancer Controller ===
# (Thay <AWS_ACCOUNT_ID> bằng Account ID của bạn)
eksctl create iamserviceaccount \
  --cluster=devops-test-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::<AWS_ACCOUNT_ID>:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve

#=== Step 3: Cài đặt AWS Load Balancer Controller bằng Helm ===
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=devops-test-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller

# Kiểm tra controller đã chạy:
kubectl get deployment -n kube-system aws-load-balancer-controller

#=== Step 4: Apply ứng dụng sample (2048 game) ===
kubectl apply -f 2048-demo.yaml

# Kiểm tra resource:
kubectl get deployment -n game-2048
kubectl get service -n game-2048
kubectl get ingress -n game-2048

#=== Step 5: Kiểm tra ALB được tạo ra ===
# Vào AWS Console -> EC2 -> Load Balancers, tìm ALB mới tạo.
# Truy cập thử game 2048 qua DNS của ALB (nhớ thêm http:// trước DNS).


#==================== PART 2: ALB cho service với Ingress path /api và / ====================

# Yêu cầu: dùng ALB làm LoadBalancer, Ingress route /api -> backend và / -> frontend.
# Sử dụng lại cluster đã tạo ở Lab 1.

#=== Step 1: Tạo file config demo-app.yaml gồm: ===
#   - Deployment + Service cho Frontend (NodePort 30088)
#   - Deployment + Service cho Backend  (NodePort 30099)
#   - Deployment + Service cho Mongo    (ClusterIP 27017)
#   - Ingress sử dụng ALB (path /api -> backend, / -> frontend)

#=== Step 2: Apply file config ===
kubectl apply -f demo-app.yaml

#=== Step 3: Kiểm tra các resource ===
kubectl get deployment
kubectl get service
kubectl get ingress

#=== Step 4: Truy cập ứng dụng qua DNS của ALB ===
#   - /      -> frontend
#   - /api   -> backend

#=== Step 5: Xoá resource ===
kubectl delete -f demo-app.yaml

#=== Step 6: Xoá EKS Cluster (hoặc giữ lại để làm lab tiếp theo) ===
eksctl delete cluster --name devops-test-cluster --region ap-southeast-1
