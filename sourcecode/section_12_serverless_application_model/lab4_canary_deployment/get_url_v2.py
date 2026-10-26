import json
import logging
import os

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


# Version v2: giống v1, chỉ đổi header X-App-Version để phân biệt request nào do version mới xử lý.
def lambda_handler(event, context):
    short_url = event["pathParameters"]["short_url"]
    logger.info("Lookup short_url=%s", short_url)

    result = table.get_item(Key={"short_url": short_url})

    if "Item" not in result:
        return {
            "statusCode": 404,
            "headers": {**CORS_HEADERS, "X-App-Version": "v2"},
            "body": json.dumps({"status": "error", "message": "URL not found"}),
        }

    original_url = result["Item"]["original_url"]
    return {
        "statusCode": 308,
        "headers": {**CORS_HEADERS, "Location": original_url, "X-App-Version": "v2"},
        "body": json.dumps({"status": "redirecting", "url": original_url}),
    }
