# Lab 3: Volume trong EKS (sử dụng EBS làm Storage Class)
# Guide chính thức: https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html
# Tái sử dụng lại resource của bài lab trước (cluster devops-test-cluster).

#=== Step 1: Tạo IAM Role cho EBS CSI Driver ===
# (Thay tên cluster nếu khác)
eksctl create iamserviceaccount \
    --name ebs-csi-controller-sa \
    --namespace kube-system \
    --cluster devops-test-cluster \
    --role-name AmazonEKS_EBS_CSI_DriverRole \
    --role-only \
    --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
    --approve

#=== Step 2: Cài đặt EBS CSI Driver add-on ===
# (Thay <AWS_ACCOUNT_ID> bằng Account ID của bạn)
eksctl create addon --name aws-ebs-csi-driver --cluster devops-test-cluster \
    --service-account-role-arn arn:aws:iam::<AWS_ACCOUNT_ID>:role/AmazonEKS_EBS_CSI_DriverRole --force

#=== Step 3: Chuẩn bị resource (StorageClass EBS + PVC + gắn vào MongoDB) ===
# Tham khảo demo-app.yaml (StorageClass ebs-sc + PVC mongo-pvc + Deployment mongo)

#=== Step 4: Apply resource cho cluster ===
kubectl apply -f demo-app.yaml

# Kiểm tra các resource đã tạo:
kubectl get storageclass
kubectl get pvc
kubectl get pv
kubectl get pods
kubectl get deployment
kubectl get service
kubectl get ingress

# Vào AWS Console kiểm tra EBS volume đã được tạo:
#   - Volume có tên: devops-test-cluster-dynamic-pvc-xxxxx
#   - Volume size: 4 GB

#=== Step 5: Truy cập ứng dụng qua DNS của ALB, insert vài dữ liệu ===

#=== Step 6: Xoá thử 1 pod MongoDB, kiểm tra pod có được tạo lại ===
kubectl get pods
kubectl delete pod <pod-name>

#=== Step 7: Truy cập lại ứng dụng qua ALB, kiểm tra data có còn không ===

#=== Step 8: Xoá resource [Optional nếu không tiếp tục sử dụng] ===
kubectl delete -f demo-app.yaml

#=== Step 9: Xoá EKS Cluster (hoặc giữ lại để làm lab tiếp theo) ===
eksctl delete cluster --name devops-test-cluster --region ap-southeast-1
