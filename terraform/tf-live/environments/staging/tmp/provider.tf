terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-bucket"
    key            = "global/s3/terraform.tfstate" # State file location in the bucket
    region         = var.aws_region
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.12"
    }
  }

  required_version = "= 1.5.7"
}

provider "aws" {
  region = var.aws_region
}
