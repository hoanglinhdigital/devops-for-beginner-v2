# Lab 2 – Triển khai ứng dụng URL Shortener bằng AWS SAM
# Tập hợp lệnh tham khảo theo thứ tự các bước – copy từng lệnh, không chạy cả file một lần.

cd sourcecode/section_12_serverless_application_model/lab2_url_shorten_app

# Kiểm tra cú pháp & best practice của template
sam validate --lint

# Build (cần Python 3.13 trên máy; nếu không có hãy thêm --use-container, yêu cầu Docker)
sam build

# Deploy lần đầu – trả lời các câu hỏi theo hướng dẫn trong bài
sam deploy --guided

# Lấy giá trị Outputs của stack
sam list stack-outputs --stack-name url-shorten-app

# Tạo short URL (thay <ApiUrl> bằng giá trị output)
curl -X POST "<ApiUrl>/generate-short-url" -H "Content-Type: application/json" -d '{"url": "https://aws.amazon.com/serverless/sam/"}'

# Truy cập link rút gọn (thay <ApiUrl> và <short_url_code>)
curl -i "<ApiUrl>/link/<short_url_code>"

# Xoá toàn bộ stack
sam delete --stack-name url-shorten-app
