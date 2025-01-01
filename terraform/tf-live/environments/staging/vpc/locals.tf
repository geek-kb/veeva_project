locals {
  environment    = "staging"
  vpc_name       = "${local.environment}-vpc"
  vpc_cidr_block = "10.0.0.0/16"
  aws_region     = "eu-west-1"
  common_tags    = {}
}

