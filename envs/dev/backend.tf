terraform {
  backend "s3" {
    bucket       = "vaultcam-tfstate-105299590519"
    key          = "envs/dev/terraform.tfstate"
    region       = "eu-west-1"
    encrypt      = true
    use_lockfile = true
  }
}

#Testing 1, 2