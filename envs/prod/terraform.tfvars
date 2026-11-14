aws_region  = "eu-west-1"
environment = "prod"
name_suffix = "jj-001"

tenants = {
  acme     = { retention_days = 365 }
  lagosmed = { retention_days = 730 }
}

alert_email = "joshuajaiyeola.segun@gmail.com"
