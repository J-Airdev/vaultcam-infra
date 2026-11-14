variable "tenant_id" {
  type        = string
  description = "Short tenant name, used in the S3 prefix and role name."
}

variable "name_prefix" {
  type        = string
  description = "Naming prefix, e.g. vaultcam-dev."
}

variable "bucket_arn" {
  type        = string
  description = "ARN of the footage bucket."
}

variable "kms_key_arn" {
  type        = string
  description = "ARN of the footage KMS key."
}