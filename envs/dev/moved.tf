# ── Tenant role (Stage 1) ──
moved {
  from = aws_iam_role.acme_uploader
  to   = module.tenant_access["acme"].aws_iam_role.uploader
}

moved {
  from = aws_iam_role_policy.acme_upload
  to   = module.tenant_access["acme"].aws_iam_role_policy.upload
}

# ── Storage ──
moved {
  from = aws_s3_bucket.footage
  to   = module.footage_storage.aws_s3_bucket.footage
}

moved {
  from = aws_s3_bucket_versioning.footage
  to   = module.footage_storage.aws_s3_bucket_versioning.footage
}

moved {
  from = aws_s3_bucket_server_side_encryption_configuration.footage
  to   = module.footage_storage.aws_s3_bucket_server_side_encryption_configuration.footage
}

moved {
  from = aws_s3_bucket_public_access_block.footage
  to   = module.footage_storage.aws_s3_bucket_public_access_block.footage
}

moved {
  from = aws_s3_bucket_lifecycle_configuration.footage
  to   = module.footage_storage.aws_s3_bucket_lifecycle_configuration.footage
}

moved {
  from = aws_kms_key.footage
  to   = module.footage_storage.aws_kms_key.footage
}

moved {
  from = aws_kms_alias.footage
  to   = module.footage_storage.aws_kms_alias.footage
}

moved {
  from = aws_s3_bucket_policy.footage
  to   = module.footage_storage.aws_s3_bucket_policy.footage
}

# ── Ingest ──
moved {
  from = aws_dynamodb_table.footage_index
  to   = module.ingest_indexer.aws_dynamodb_table.footage_index
}

moved {
  from = aws_iam_role.indexer
  to   = module.ingest_indexer.aws_iam_role.indexer
}

moved {
  from = aws_iam_role_policy.indexer
  to   = module.ingest_indexer.aws_iam_role_policy.indexer
}

moved {
  from = aws_lambda_function.indexer
  to   = module.ingest_indexer.aws_lambda_function.indexer
}

moved {
  from = aws_lambda_permission.allow_s3
  to   = module.ingest_indexer.aws_lambda_permission.allow_s3
}

moved {
  from = aws_s3_bucket_notification.footage
  to   = module.ingest_indexer.aws_s3_bucket_notification.footage
}