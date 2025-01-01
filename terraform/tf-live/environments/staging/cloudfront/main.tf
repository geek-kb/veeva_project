
module "cloudfront" {
  source         = "../../../../tf-modules/cloudfront"
  environment    = local.environment
  common_tags    = local.common_tags
  target_origin_id = module.s3.target_origin_id
  cloudfront_distribution_website_endpoint = module.s3.cloudfront_distribution_website_endpoint
  cloudfront_distribution_bucket_id = module.s3.cloudfront_distribution_bucket_id
  cloudfront_distribution_bucket_arn = module.s3.cloudfront_distribution_bucket_arn
  cloudfront_distribution_bucket_name = module.s3.cloudfront_distribution_bucket_name
  cloudfront_distribution_domain_name = module.s3.cloudfront_distribution_domain_name
}

# module "s3" {
#   source         = "../../../../tf-modules/s3"
#   aws_region     = local.aws_region
#   aws_account_id = local.aws_account_id
#   environment    = local.environment
#   # cloudfront_distribution_bucket_name = module.s3.cloudfront_distribution_bucket_name
#   # cloudfront_distribution_create_bucket          = local.cloudfront_distribution_create_bucket
#   # cloudfront_distribution_force_destroy           = local.cloudfront_distribution_s3_force_destroy
#   # cloudfront_distribution_s3_bucket_acl = local.cloudfront_distribution_s3_bucket_acl
#   # cdn_logs_retention_days = local.cdn_logs_retention_days
#   # cdn_logs_bucket_name = local.cdn_logs_bucket_name
# }