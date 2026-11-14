module "tenant_access" {
  source   = "../../modules/tenant-access"
  for_each = var.tenants

  tenant_id   = each.key
  name_prefix = local.name_prefix
  bucket_arn  = module.footage_storage.bucket_arn
  kms_key_arn = module.footage_storage.kms_key_arn
}

output "tenant_role_arns" {
  description = "Uploader role ARN for each tenant."
  value       = { for name, m in module.tenant_access : name => m.role_arn }
}