output "footage_bucket_name" {
  description = "Name of the footage bucket."
  value       = module.footage_storage.bucket_name
}

output "footage_bucket_arn" {
  description = "ARN of the footage bucket."
  value       = module.footage_storage.bucket_arn
}

output "index_table_name" {
  description = "Name of the footage index table."
  value       = module.ingest_indexer.table_name
}

output "indexer_function_name" {
  description = "Name of the indexer Lambda function."
  value       = module.ingest_indexer.function_name
}