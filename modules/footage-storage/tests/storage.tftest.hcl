# Use a pretend AWS provider: no credentials, nothing created, no cost
mock_provider "aws" {}

# The bucket policy needs valid JSON; give the policy document a fixed value
override_data {
  target = data.aws_iam_policy_document.tls_only
  values = {
    json = "{\"Version\":\"2012-10-17\",\"Statement\":[]}"
  }
}

# Inputs used by every test unless a test overrides them
variables {
  name_prefix = "vaultcam-test"
  name_suffix = "t1"
  tenants = {
    acme     = { retention_days = 365 }
    lagosmed = { retention_days = 730 }
  }
}

run "one_rule_per_tenant" {
  command = plan

  assert {
    condition     = length(aws_s3_bucket_lifecycle_configuration.footage.rule) == 2
    error_message = "Expected exactly one lifecycle rule per tenant."
  }
}

run "every_rule_reaches_deep_archive" {
  command = plan

  assert {
    condition = alltrue([
      for r in aws_s3_bucket_lifecycle_configuration.footage.rule :
      contains([for t in r.transition : t.storage_class], "DEEP_ARCHIVE")
    ])
    error_message = "Every tenant's footage must eventually move to DEEP_ARCHIVE."
  }
}

run "retention_matches_each_tenant" {
  command = plan

  assert {
    condition = {
      for r in aws_s3_bucket_lifecycle_configuration.footage.rule :
      r.id => r.expiration[0].days
    } == { "tier-acme" = 365, "tier-lagosmed" = 730 }
    error_message = "Each tenant's rule must expire footage after that tenant's retention_days."
  }
}

run "bucket_name_follows_convention" {
  command = plan

  assert {
    condition     = aws_s3_bucket.footage.bucket == "vaultcam-test-footage-t1"
    error_message = "Bucket name must be <name_prefix>-footage-<name_suffix>."
  }
}

run "rejects_short_retention" {
  command = plan

  variables {
    tenants = {
      shortstay = { retention_days = 100 }
    }
  }

  expect_failures = [var.tenants]
}