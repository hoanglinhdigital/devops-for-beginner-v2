import json
import os
import sys

# Biến môi trường giả để import module không cần credential/AWS thật
os.environ.setdefault("AWS_DEFAULT_REGION", "ap-southeast-1")
os.environ.setdefault("TABLE_NAME", "unit-test-table")

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", "generate_short_url"))
import app  # noqa: E402


def test_empty_body_returns_400():
    result = app.lambda_handler({"body": None}, None)
    assert result["statusCode"] == 400


def test_invalid_json_returns_400():
    result = app.lambda_handler({"body": "not-json"}, None)
    assert result["statusCode"] == 400


def test_missing_url_returns_400():
    result = app.lambda_handler({"body": json.dumps({"foo": "bar"})}, None)
    assert result["statusCode"] == 400
    assert "url" in json.loads(result["body"])["message"]
