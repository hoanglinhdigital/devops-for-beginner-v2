# Tạo headless Service + StatefulSet nginx 3 Pod (mỗi Pod có PVC riêng).
kubectl apply -f nginx-statefulset.yaml
# Quan sát Pod được tạo theo thứ tự web-0 -> web-1 -> web-2 (Ctrl + C để thoát).
kubectl get pods -l app=nginx-sts -w
kubectl get statefulset
kubectl get pvc
kubectl get pv

# Ghi data riêng vào từng Pod.
kubectl exec web-0 -- sh -c 'echo "Hello from web-0" > /usr/share/nginx/html/index.html'
kubectl exec web-1 -- sh -c 'echo "Hello from web-1" > /usr/share/nginx/html/index.html'
kubectl exec web-2 -- sh -c 'echo "Hello from web-2" > /usr/share/nginx/html/index.html'

# Truy cập từng Pod qua DNS ổn định <tên-pod>.<tên-service>.
kubectl run dns-test --image=busybox:1.36 --rm -i --restart=Never -- nslookup web-0.nginx-headless
kubectl run dns-test --image=busybox:1.36 --rm -i --restart=Never -- wget -qO- http://web-0.nginx-headless
kubectl run dns-test --image=busybox:1.36 --rm -i --restart=Never -- wget -qO- http://web-1.nginx-headless

# Xoá 1 Pod, Pod mới giữ nguyên tên và data.
kubectl delete pod web-1
kubectl get pods -l app=nginx-sts -w
kubectl exec web-1 -- cat /usr/share/nginx/html/index.html

# Scale down (xoá theo thứ tự ngược web-2 -> web-1), PVC vẫn còn.
kubectl scale statefulset web --replicas=1
kubectl get pods -l app=nginx-sts -w
kubectl get pvc
# Scale up lại, data của web-2 vẫn còn.
kubectl scale statefulset web --replicas=3
kubectl rollout status statefulset/web
kubectl exec web-2 -- cat /usr/share/nginx/html/index.html

# Xoá resource (PVC phải xoá thủ công).
kubectl delete -f nginx-statefulset.yaml
kubectl delete pvc www-web-0 www-web-1 www-web-2
kubectl get pods,pvc,pv
