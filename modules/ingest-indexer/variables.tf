variable "name_prefix" {
  type        = string
  description = "Naming prefix, e.g. vaultcam-dev."
}

variable "bucket_id" {
  type        = string
  description = "ID (name) of the footage bucket that sends upload events."
}

variable "bucket_arn" {
  type        = string
  description = "ARN of the footage bucket."
}

variable "lambda_source_file" {
  type        = string
  description = "Path to indexer.py."
}

variable "lambda_zip_path" {
  type        = string
  description = "Where to write the packaged Lambda ZIP."
}