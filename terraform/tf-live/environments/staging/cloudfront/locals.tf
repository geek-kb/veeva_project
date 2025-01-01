locals {
  environment    = "staging"
  project = "frontend"
  vpc_name       = "${local.environment}-vpc"
  aws_region     = "eu-west-1"
  aws_account_id = "912466608750"
  common_tags    = {}
  cloudfront_distribution_create_bucket          = true
  cloudfront_distribution_s3_force_destroy = true
  cloudfront_distribution_bucket_name             = "${local.environment}-${local.project}-bucket"
  cloudfront_distribution_s3_bucket_acl = "public-read"
  cdn_logs_bucket_name = "${local.environment}-${local.project}-cdn-logs-bucket"
  cdn_logs_retention_days = 90
  cdn_logs_bucket_force_destroy                      = true
  cdn_logs_s3_bucket_acl                             = "private"
}

