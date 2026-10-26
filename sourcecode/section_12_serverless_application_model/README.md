# Section 12 – Serverless Application Model (SAM)

Source code cho các bài lab của Section 12. Nội dung hướng dẫn: `sections/section_12/`.

Yêu cầu: AWS CLI v2 đã cấu hình profile, **AWS SAM CLI**, **Python 3.13** (hoặc dùng `sam build --use-container`), **Docker** (cho `sam local`). Region dùng trong lab: `ap-southeast-1`.

Các file `commands.sh` là **tập hợp lệnh tham khảo** theo thứ tự các bước, không chạy cả file một lần — copy từng lệnh và chạy trong Terminal.

| Folder | Bài lab | Ghi chú |
|---|---|---|
| `lab1_hello_world/` | Lab 1 – Cài SAM CLI, `sam init`, build, local, deploy Hello World | Project `sam-app` do `sam init` sinh ra, không lưu trong repo |
| `lab2_url_shorten_app/` | Lab 2 – Ứng dụng URL Shortener (API Gateway + Lambda + DynamoDB) | Project SAM hoàn chỉnh, stack `url-shorten-app`, dùng tiếp cho Lab 3 & Lab 4 |
| `lab3_local_test_and_sync/` | Lab 3 – `sam local`, unit test, `sam logs`, `sam sync` | Chỉ có `commands.sh`, thao tác trên project Lab 2 |
| `lab4_canary_deployment/` | Lab 4 – Canary deployment cho Lambda (`AutoPublishAlias` + `DeploymentPreference` + Alarm) | `template.yaml` thay thế template Lab 2; `get_url_v2.py`, `get_url_v3_broken.py` |

## Ứng dụng URL Shortener
- `POST /generate-short-url` body `{"url": "https://..."}` → trả `{"short_url_code": "..."}` và lưu vào DynamoDB.
- `GET /link/{short_url}` → tra cứu URL gốc và trả HTTP 308 redirect (404 nếu không có).
- Tên DynamoDB table do CloudFormation sinh tự động, truyền vào Lambda qua biến môi trường `TABLE_NAME` (khai báo trong `Globals`).
- IAM permission dùng **SAM policy templates** (`DynamoDBWritePolicy`, `DynamoDBReadPolicy`) – least privilege theo từng function.
- `samconfig.toml` do `sam deploy --guided` sinh ra và đã được gitignore.
