aws_region  = "eu-west-1"
environment = "dev"
name_suffix = "jj-001"

tenants = {
  acme     = { retention_days = 365 }
  lagosmed = { retention_days = 730 }
}