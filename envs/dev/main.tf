provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "vaultcam"
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}

module "footage_storage" {
  source = "../../modules/footage-storage"

  name_prefix = local.name_prefix
  name_suffix = var.name_suffix
  tenants     = var.tenants
}

module "ingest_indexer" {
  source = "../../modules/ingest-indexer"

  name_prefix        = local.name_prefix
  bucket_id          = module.footage_storage.bucket_id
  bucket_arn         = module.footage_storage.bucket_arn
  lambda_source_file = "${path.module}/../../lambda/indexer.py"
  lambda_zip_path    = "${path.module}/build/indexer.zip"
}
