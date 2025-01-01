data "aws_region" "current" {}

locals {
  bucket_name = length(aws_s3_bucket.frontend) > 0 ? aws_s3_bucket.frontend[0].bucket : var.cloudfront_distribution_bucket_name

  s3_website_endpoint = length(regexall("^(us|ap|eu|sa|ca|me|af|cn|il)-", data.aws_region.current.name)) > 0 ? "${local.bucket_name}.s3-website.${data.aws_region.current.name}.amazonaws.com" : "${local.bucket_name}.s3-website-${data.aws_region.current.name}.amazonaws.com"
  cloudfront_distribution_bucket_name = "${var.cloudfront_distribution_bucket_name}-${random_string.suffix.id}"
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "aws_s3_bucket" "frontend" {
  count = var.cloudfront_distribution_create_bucket ? 1 : 0
  bucket        = local.cloudfront_distribution_bucket_name
  force_destroy = var.cloudfront_distribution_force_destroy
  tags = merge(var.common_tags, {
    Name        = "${var.cloudfront_distribution_bucket_name}-${random_string.suffix.id}",
    Environment = var.environment
    ManagedBy   = "Terraform"
  })
}

resource "aws_s3_bucket" "cdn_logs" {
  bucket        = "${var.cdn_logs_bucket_name}-${random_string.suffix.id}"
  force_destroy = var.cdn_logs_bucket_force_destroy

  tags = merge(var.common_tags, {
    Name        = "${var.cdn_logs_bucket_name}-${random_string.suffix.id}",
    Environment = var.environment
    ManagedBy   = "Terraform"
  })
}
