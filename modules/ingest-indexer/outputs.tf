output "table_name" {
  description = "Name of the footage index table."
  value       = aws_dynamodb_table.footage_index.name
}

output "function_name" {
  description = "Name of the indexer Lambda function."
  value       = aws_lambda_function.indexer.function_name
}