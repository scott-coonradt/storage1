# index.py

import boto3
import os
import json
import urllib3

rds = boto3.client('rds-data')
http = urllib3.PoolManager()

DB_CLUSTER_ARN = os.environ['DB_CLUSTER_ARN']
DB_SECRET_ARN = os.environ['DB_SECRET_ARN']
DATABASE_NAME = os.environ['DATABASE_NAME']
TABLE_NAME = os.environ['TABLE_NAME']

def send_response(event, context, status, reason=None):
    response_body = json.dumps({
        "Status": status,
        "Reason": reason or f"See CloudWatch Logs: {context.log_stream_name}",
        "PhysicalResourceId": context.log_stream_name,
        "StackId": event["StackId"],
        "RequestId": event["RequestId"],
        "LogicalResourceId": event["LogicalResourceId"],
    })
    headers = {'content-type': '', 'content-length': str(len(response_body))}
    http.request('PUT', event['ResponseURL'], body=response_body, headers=headers)

def handler(event, context):
    try:
        request_type = event['RequestType']
        print(f"Event received: {json.dumps(event)}")

        if request_type == 'Create':
            # Ensure DB exists
            rds.execute_statement(
                resourceArn=DB_CLUSTER_ARN,
                secretArn=DB_SECRET_ARN,
                sql=f"CREATE DATABASE IF NOT EXISTS {DATABASE_NAME}"
            )

            # Create table in PostgreSQL
            rds.execute_statement(
                resourceArn=DB_CLUSTER_ARN,
                secretArn=DB_SECRET_ARN,
                database=DATABASE_NAME,
                sql=f"""
                CREATE TABLE IF NOT EXISTS {TABLE_NAME} (
                    id SERIAL PRIMARY KEY,
                    name VARCHAR(255),
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
                """
            )

        elif request_type == 'Update':
            # Idempotent: Ensure DB still exists
            rds.execute_statement(
                resourceArn=DB_CLUSTER_ARN,
                secretArn=DB_SECRET_ARN,
                sql=f"CREATE DATABASE IF NOT EXISTS {DATABASE_NAME}"
            )
            # Could add ALTER TABLE logic here for schema changes

        elif request_type == 'Delete':
            # Optional: Drop resources (careful in production!)
            try:
                rds.execute_statement(
                    resourceArn=DB_CLUSTER_ARN,
                    secretArn=DB_SECRET_ARN,
                    database=DATABASE_NAME,
                    sql=f"DROP TABLE IF EXISTS {TABLE_NAME}"
                )
            except Exception as e:
                print(f"Error dropping table: {e}")

            try:
                rds.execute_statement(
                    resourceArn=DB_CLUSTER_ARN,
                    secretArn=DB_SECRET_ARN,
                    sql=f"DROP DATABASE IF EXISTS {DATABASE_NAME}"
                )
            except Exception as e:
                print(f"Error dropping database: {e}")

        send_response(event, context, "SUCCESS")

    except Exception as e:
        print(f"Error: {e}")
        send_response(event, context, "FAILED", reason=str(e))

