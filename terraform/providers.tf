provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

terraform {
  backend "s3" {
    region = "us-east-1"
  }
}
