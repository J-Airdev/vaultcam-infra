# ── The footage bucket ──
resource "aws_s3_bucket" "footage" {
  bucket = "${var.name_prefix}-footage-${var.name_suffix}"
}

resource "aws_s3_bucket_versioning" "footage" {
  bucket = aws_s3_bucket.footage.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "footage" {
  bucket = aws_s3_bucket.footage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.footage.arn
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "footage" {
  bucket                  = aws_s3_bucket.footage.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ── The encryption key ──
resource "aws_kms_key" "footage" {
  description         = "Encrypts VaultCam footage"
  enable_key_rotation = true
}

resource "aws_kms_alias" "footage" {
  name          = "alias/${var.name_prefix}-footage"
  target_key_id = aws_kms_key.footage.key_id
}

# ── Refuse non-HTTPS requests ──
data "aws_iam_policy_document" "tls_only" {
  statement {
    effect    = "Deny"
    actions   = ["s3:*"]
    resources = [aws_s3_bucket.footage.arn, "${aws_s3_bucket.footage.arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_s3_bucket_policy" "footage" {
  bucket = aws_s3_bucket.footage.id
  policy = data.aws_iam_policy_document.tls_only.json
}
