variable "aws_region" {
  type        = string
  description = "AWS Region for all resources."
  default     = "eu-west-1"
}

variable "environment" {
  type        = string
  description = "Deployment environment."

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "environment must be either \"dev\" or \"prod\"."
  }
}

variable "name_suffix" {
  type        = string
  description = "Short unique suffix that makes S3 bucket names globally unique."
}

variable "retention_days" {
  type        = number
  description = "Days after upload before footage is expired."
  default     = 365

  validation {
    condition     = var.retention_days >= 360
    error_message = "retention_days must be at least 360, so footage spends the 180-day minimum in DEEP_ARCHIVE (transition at day 180)."
  }
}

variable "tenants" {
  type = map(object({
    retention_days = number
  }))
  description = "Tenants and their footage retention periods."

  validation {
    condition     = alltrue([for t in var.tenants : t.retention_days >= 360])
    error_message = "Each tenant's retention_days must be at least 360."
  }
}