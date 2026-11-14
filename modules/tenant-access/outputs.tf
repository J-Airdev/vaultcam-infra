output "role_arn" {
  description = "ARN of the tenant's uploader role."
  value       = aws_iam_role.uploader.arn
}
