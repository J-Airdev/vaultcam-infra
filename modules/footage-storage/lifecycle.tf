resource "aws_s3_bucket_lifecycle_configuration" "footage" {
  bucket     = aws_s3_bucket.footage.id
  depends_on = [aws_s3_bucket_versioning.footage]

  dynamic "rule" {
    for_each = var.tenants

    content {
      id     = "tier-${rule.key}"
      status = "Enabled"

      filter {
        prefix = "recordings/${rule.key}/"
      }

      transition {
        days          = 30
        storage_class = "STANDARD_IA"
      }
      transition {
        days          = 90
        storage_class = "GLACIER_IR"
      }
      transition {
        days          = 180
        storage_class = "DEEP_ARCHIVE"
      }

      expiration {
        days = rule.value.retention_days
      }

      noncurrent_version_expiration {
        noncurrent_days = 30
      }

      abort_incomplete_multipart_upload {
        days_after_initiation = 7
      }
    }
  }
}