# ── 1. The index table ──
resource "aws_dynamodb_table" "footage_index" {
  name         = "${var.name_prefix}-footage-index"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "tenant_id"
  range_key    = "object_key"

  attribute {
    name = "tenant_id"
    type = "S"
  }
  attribute {
    name = "object_key"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }
}

# ── 2. The Lambda's execution role ──
data "aws_iam_policy_document" "indexer_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "indexer" {
  name               = "${var.name_prefix}-indexer-role"
  assume_role_policy = data.aws_iam_policy_document.indexer_trust.json
}

data "aws_iam_policy_document" "indexer_permissions" {
  statement {
    actions   = ["dynamodb:PutItem"]
    resources = [aws_dynamodb_table.footage_index.arn]
  }
  statement {
    actions   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

resource "aws_iam_role_policy" "indexer" {
  name   = "indexer-permissions"
  role   = aws_iam_role.indexer.id
  policy = data.aws_iam_policy_document.indexer_permissions.json
}

# ── 3. Package and deploy the function ──
data "archive_file" "indexer" {
  type        = "zip"
  source_file = var.lambda_source_file
  output_path = var.lambda_zip_path
}

resource "aws_lambda_function" "indexer" {
  function_name    = "${var.name_prefix}-indexer"
  role             = aws_iam_role.indexer.arn
  handler          = "indexer.handler"
  runtime          = "python3.13"
  filename         = data.archive_file.indexer.output_path
  source_code_hash = data.archive_file.indexer.output_base64sha256

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.footage_index.name
    }
  }
}

# ── 4. Allow S3 to call the function ──
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.indexer.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.bucket_arn
}

# ── 5. Tell S3 to send upload events to the function ──
resource "aws_s3_bucket_notification" "footage" {
  bucket = var.bucket_id

  lambda_function {
    lambda_function_arn = aws_lambda_function.indexer.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "recordings/"
    filter_suffix       = ".mp4"
  }

  depends_on = [aws_lambda_permission.allow_s3]
}