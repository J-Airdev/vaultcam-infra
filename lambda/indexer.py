import os
import urllib.parse
import boto3

table = boto3.resource("dynamodb").Table(os.environ["TABLE_NAME"])

def handler(event, context):
    for record in event["Records"]:
        key = urllib.parse.unquote_plus(record["s3"]["object"]["key"])
        # expected: recordings/<tenant>/<camera>/<file>.mp4
        _, tenant, camera, _filename = key.split("/", 3)
        table.put_item(Item={
            "tenant_id": tenant,
            "object_key": key,
            "camera_id": camera,
            "size_bytes": record["s3"]["object"]["size"],
            "event_time": record["eventTime"],
        })