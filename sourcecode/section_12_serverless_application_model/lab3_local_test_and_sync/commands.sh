# Lab 3 – Test ở local, xem log & cập nhật nhanh bằng sam sync
# Thực hiện trong thư mục project của Lab 2 (stack url-shorten-app đã deploy).
# Tập hợp lệnh tham khảo theo thứ tự các bước – copy từng lệnh, không chạy cả file một lần.

cd sourcecode/section_12_serverless_application_model/lab2_url_shorten_app

# Chạy unit test
pip install -r tests/requirements.txt
python -m pytest tests/unit -v

# Lấy tên DynamoDB table thật, điền vào env.json (copy từ env.json.example)
sam list stack-outputs --stack-name url-shorten-app
cp env.json.example env.json

# Invoke 1 function ở local bằng event mẫu (cần Docker)
sam build
sam local invoke GenerateShortUrlFunction --event events/generate.json --env-vars env.json

# Chạy API ở local (http://127.0.0.1:3000)
sam local start-api --env-vars env.json
curl -X POST http://127.0.0.1:3000/generate-short-url -H "Content-Type: application/json" -d '{"url": "https://docs.aws.amazon.com/"}'

# Xem endpoint & log của stack đã deploy
sam list endpoints --stack-name url-shorten-app
sam logs --stack-name url-shorten-app --name GenerateShortUrlFunction --tail

# Đồng bộ code lên AWS nhanh, không qua changeset (chỉ dùng cho môi trường dev)
sam sync --stack-name url-shorten-app --watch
