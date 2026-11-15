# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_sns_topic" "manual" {
  application_failure_feedback_role_arn    = null
  application_success_feedback_role_arn    = null
  application_success_feedback_sample_rate = 0
  archive_policy                           = null
  content_based_deduplication              = false
  delivery_policy                          = null
  display_name                             = null
  fifo_topic                               = false
  firehose_failure_feedback_role_arn       = null
  firehose_success_feedback_role_arn       = null
  firehose_success_feedback_sample_rate    = 0
  http_failure_feedback_role_arn           = null
  http_success_feedback_role_arn           = null
  http_success_feedback_sample_rate        = 0
  kms_master_key_id                        = null
  lambda_failure_feedback_role_arn         = null
  lambda_success_feedback_role_arn         = null
  lambda_success_feedback_sample_rate      = 0
  maximum_message_size                     = 262144
  name                                     = "vaultcam-dev-manual-topic"
  policy = jsonencode({
    Id = "__default_policy_ID"
    Statement = [{
      Action = ["SNS:Publish", "SNS:RemovePermission", "SNS:SetTopicAttributes", "SNS:DeleteTopic", "SNS:ListSubscriptionsByTopic", "SNS:GetTopicAttributes", "SNS:AddPermission", "SNS:Subscribe"]
      Condition = {
        StringEquals = {
          "AWS:SourceAccount" = "105299590519"
        }
      }
      Effect = "Allow"
      Principal = {
        AWS = "*"
      }
      Resource = "arn:aws:sns:eu-west-1:105299590519:vaultcam-dev-manual-topic"
      Sid      = "__default_statement_ID"
    }]
    Version = "2008-10-17"
  })
  region                           = "eu-west-1"
  sqs_failure_feedback_role_arn    = null
  sqs_success_feedback_role_arn    = null
  sqs_success_feedback_sample_rate = 0
  tags = {
    type = "Manual"
  }
  tags_all = {
    type = "Manual"
  }
  tracing_config = "PassThrough"
}
