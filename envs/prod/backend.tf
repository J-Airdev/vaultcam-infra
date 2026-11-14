terraform {
  backend "s3" {
    bucket       = "vaultcam-tfstate-105299590519"
    key          = "envs/prod/terraform.tfstate"
    region       = "eu-west-1"
    encrypt      = true
    use_lockfile = true
  }
}