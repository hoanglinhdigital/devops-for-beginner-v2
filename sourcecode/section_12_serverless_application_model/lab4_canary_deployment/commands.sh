# Lab 4 – Canary deployment cho Lambda bằng SAM + CodeDeploy
# Tập hợp lệnh tham khảo theo thứ tự các bước – copy từng lệnh, không chạy cả file một lần.
# Chạy từ thư mục gốc của repository (khoá học).

# Bước 1: baseline v1 – thay template của Lab 2 bằng template có AutoPublishAlias + DeploymentPreference
cp sourcecode/section_12_serverless_application_model/lab4_canary_deployment/template.yaml sourcecode/section_12_serverless_application_model/lab2_url_shorten_app/template.yaml
cd sourcecode/section_12_serverless_application_model/lab2_url_shorten_app
sam build
sam deploy

# Bước 2: release v2 (canary 10% trong 5 phút)
cp ../lab4_canary_deployment/get_url_v2.py get_url/app.py
sam build
sam deploy

# Trong lúc deploy (mở terminal khác): đếm tỷ lệ v1/v2 (thay <ApiUrl> và <short_url_code>)
for i in $(seq 1 30); do curl -s -o /dev/null -D - "<ApiUrl>/link/<short_url_code>" | grep -i "x-app-version"; done | sort | uniq -c

# Bước 3: release v3 bị lỗi -> alarm -> CodeDeploy tự rollback
cp ../lab4_canary_deployment/get_url_v3_broken.py get_url/app.py
sam build
sam deploy

# Trong lúc deploy (terminal khác): tạo traffic liên tục để Lambda sinh metric Errors
for i in $(seq 1 100); do curl -s -o /dev/null -w "%{http_code}\n" "<ApiUrl>/link/<short_url_code>"; sleep 3; done

# Dọn dẹp
sam delete --stack-name url-shorten-app
