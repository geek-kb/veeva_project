terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-bucket-qjdea2"       # Replace with your S3 bucket name
    key            = "staging/s3/terraform.tfstate"          # Unique key for the workspace
    region         = "eu-west-1"                       # Replace with your AWS region
    dynamodb_table = "terraform-state-locks"              # DynamoDB table for state locking
    encrypt        = true                                 # Encrypt the state file
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.12"
    }
  }

  required_version = "1.5.5"
}

provider "aws" {
  region = local.aws_region
}