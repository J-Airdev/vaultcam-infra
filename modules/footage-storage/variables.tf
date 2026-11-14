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
}
