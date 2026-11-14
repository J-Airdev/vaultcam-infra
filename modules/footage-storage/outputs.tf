output "bucket_name" {
  description = "Name of the footage bucket."
  value       = aws_s3_bucket.footage.bucket
}

output "bucket_id" {
  description = "ID of the footage bucket (same as its name)."
  value       = aws_s3_bucket.footage.id
}

output "bucket_arn" {
  description = "ARN of the footage bucket."
  value       = aws_s3_bucket.footage.arn
}

output "kms_key_arn" {
  description = "ARN of the KMS key that encrypts footage."
  value       = aws_kms_key.footage.arn
}