import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


# Version v3 CỐ TÌNH BỊ LỖI để minh hoạ rollback tự động: mọi request đều ném exception.
def lambda_handler(event, context):
    logger.info("v3 started")
    raise RuntimeError("Simulated bug in v3 - dùng để kích hoạt CloudWatch Alarm và rollback")
