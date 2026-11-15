variable "name_prefix" {
  type        = string
  description = "Naming prefix, e.g. vaultcam-dev."
}

variable "name_suffix" {
  type        = string
  description = "Short unique suffix that makes the bucket name globally unique."
}

variable "tenants" {
  type = map(object({
    retention_days = number
  }))
  description = "Tenants and their footage retention periods."

  validation {
    condition     = alltrue([for t in var.tenants : t.retention_days >= 360])
    error_message = "Each tenant's retention_days must be at least 360, so footage completes Deep Archive's 180-day minimum."
  }
}