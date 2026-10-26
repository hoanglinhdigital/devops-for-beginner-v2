import json
import logging
import os
import secrets
import string

import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Khởi tạo bên ngoài handler để tái sử dụng kết nối giữa các lần invoke (warm start)
dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["TABLE_NAME"])

CORS_HEADERS = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
    "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
}


def response(status_code, body):
    return {"statusCode": status_code, "headers": CORS_HEADERS, "body": json.dumps(body)}


# Nhận URL gốc, sinh mã rút gọn và lưu vào DynamoDB.
# Request body (JSON): {"url": "https://www.example.com"}
def lambda_handler(event, context):
    logger.info("Received request")

    try:
        body = json.loads(event.get("body") or "{}")
    except json.JSONDecodeError:
        return response(400, {"status": "error", "message": "Request body is not valid JSON"})

    original_url = body.get("url")
    if not original_url:
        return response(400, {"status": "error", "message": "Attribute 'url' is required"})

    alphabet = string.ascii_letters + string.digits
    short_url = "".join(secrets.choice(alphabet) for _ in range(15))

    try:
        table.put_item(Item={"short_url": short_url, "original_url": original_url})
    except Exception as e:
        logger.exception("Cannot write to DynamoDB")
        return response(500, {"status": "error", "message": str(e)})

    return response(200, {"short_url_code": short_url})
