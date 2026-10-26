# Section 13 – Kubernetes (k8s) cơ bản

Source code cho các bài lab của Section 13. Nội dung hướng dẫn: `sections/section_13/`.

Yêu cầu chung: **Docker Desktop**, **kubectl** và **Minikube** đã cài đặt (Lab 1). Lab 4 – 5 chạy trên **EC2 Ubuntu** có **AWS CLI v2**, **kops** và một **domain** (mua tại Route 53). Region dùng trong lab: `ap-southeast-1`.

Các file `commands.sh` là **tập hợp lệnh tham khảo** theo thứ tự các bước, **không chạy cả file một lần** — copy từng lệnh và chạy trong Terminal. Các file `*.yaml` là manifest Kubernetes, copy nội dung để tạo file cục bộ (hoặc dùng trực tiếp với `kubectl apply -f`).

| Folder | Bài lab | Ghi chú |
|---|---|---|
| `lab1_minikube_first_pod/` | Lab 1 – Cài đặt Minikube & kubectl, chạy Pod đầu tiên (`kubectl run` + file YAML) | `nginx-pod.yaml` + `commands.sh` (3 phần) |
| `namespace/` | Namespace – tạo & chuyển namespace | Demo nhỏ, lồng trong chương lý thuyết Namespace |
| `replica_set/` | ReplicaSet – tạo 5 bản sao nginx, quan sát tự phục hồi | `nginx-replicaset.yaml` + `commands.sh`; thực hành lồng trong chương ReplicaSet |
| `deployment/` | Deployment – update image & rollback | `nginx-deployment.yaml` + `commands.sh`; thực hành lồng trong chương Deployment |
| `lab2_service_nodeport/` | Lab 2 – Service NodePort (nginx) | `nginx-nodeport.yaml` (Deployment + Service) + `commands.sh` |
| `lab3_service_clusterip/` | Lab 3 – Service ClusterIP (MongoDB) | `mongo-cluster.yaml` + `commands.sh` |
| `ingress/` | Ingress routing theo host / theo path | `ingress-demo.yaml` (host), `ingress-demo-path.yaml` (path) + `commands.sh`; thực hành lồng trong chương Ingress |
| `persistent_volume/` | PersistentVolume + PVC + MySQL (NodePort) | `persistent-volume.yaml`, `script.sql` + `commands.sh`; thực hành lồng trong chương Persistent Volume |
| `configmap/` | ConfigMap truyền env cho MySQL | `configmap-simple.yaml` + `commands.sh`; thực hành lồng trong chương ConfigMap |
| `secret/` | Secret (base64) truyền env cho MySQL | `secret-simple.yaml` + `commands.sh`; thực hành lồng trong chương Secret |
| `stateful_set/` | StatefulSet – headless Service + 3 Pod nginx có PVC riêng, DNS ổn định, scale theo thứ tự | `nginx-statefulset.yaml` + `commands.sh`; thực hành lồng trong chương StatefulSet |
| `lab4_kops/` | Lab 4 – Tạo Kubernetes cluster bằng kops trên AWS | `commands.sh` (cài kops, tạo cluster, kết nối) |
| `lab5_deploy_resources/` | Lab 5 – Triển khai app React + Express + MongoDB | `lab5.yaml` (mongo, backend, frontend, Ingress) + `commands.sh` |

## Lưu ý

- **Lab 1 – 3** và các phần thực hành lồng trong chương lý thuyết (ReplicaSet, Deployment, Ingress, Persistent Volume, ConfigMap, Secret, StatefulSet) chạy trên **Minikube** (local, không tốn phí cloud). Nhớ chạy `minikube start` trước và `minikube stop` khi không học.
- **Ingress** (thực hành trong chương Ingress) cần build 2 image từ repo `hoanglinhdigital/nodejs-random-color` (print ra message Service-A / Service-B). Thay `<your-dockerhub-account>` bằng Docker Hub account của bạn khi build & push. Hai file `ingress-demo*.yaml` đang trỏ tới image `hoanglinhdigital/nodejs-random-color:*` của giảng viên để tiện chạy demo — nếu bạn tự build image, sửa lại trường `image` trong manifest cho khớp.
- **Persistent Volume, ConfigMap, Secret** dùng `hostPath` cho PersistentVolume (phù hợp Minikube một node). Trên cluster thật hãy dùng StorageClass + EBS/EFS.
- **Secret** yêu cầu mã hoá base64: dùng `echo -n "..." | base64` và thay vào file `secret-simple.yaml`.
- **Lab 4**: thay `hoanglinhdigital.com` bằng domain của bạn và `udemy-devops-kops` bằng tên S3 bucket state của bạn. EC2 cần IAM Role có `AdministratorAccess`. Xoá cluster ngay sau khi dùng để tránh tốn phí.
- **Lab 5**: thay `<AWS_ACCOUNT_ID>` trong `lab5.yaml` bằng Account ID của bạn; build image rồi push lên ECR (`devops-lab13-backend`, `devops-lab13-frontend`) trước khi apply. Đây là lab trên cluster thật (kops) — xoá ALB, Target Group, cluster và EC2 sau khi học xong.
- So với phiên bản cũ: thay Account ID cứng bằng placeholder `<AWS_ACCOUNT_ID>` trong `lab5.yaml`, sửa lỗi typo tag image `service-a` → `service-b` trong `ingress/commands.sh`, và đưa tất cả command vào file `commands.sh` theo thứ tự thực hiện.
