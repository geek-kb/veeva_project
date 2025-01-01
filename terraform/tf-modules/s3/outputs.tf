# output "cloudfront_distribution_bucket_name" {
#   description = "The name of the S3 bucket"
#   value       = aws_s3_bucket.frontend.bucket
# }

output "cloudfront_distribution_website_endpoint" {
  description = "The S3 bucket website endpoint"
  value       = local.s3_website_endpoint
}

# output "cloudfront_distribution_bucket_id" {
#   description = "The ID of the S3 bucket"
#   value       = aws_s3_bucket.frontend.id
# }

# output "cloudfront_distribution_bucket_arn" {
#   description = "The ARN of the S3 bucket"
#   value       = aws_s3_bucket.frontend.arn
# }


output "cloudfront_distribution_bucket_name" {
  description = "The name of the S3 bucket"
  value       = length(aws_s3_bucket.frontend) > 0 ? aws_s3_bucket.frontend[0].id : null
}

output "cloudfront_distribution_bucket_id" {
  description = "The ID of the S3 bucket"
  value       = length(aws_s3_bucket.frontend) > 0 ? aws_s3_bucket.frontend[0].id : null
}

output "cloudfront_distribution_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = length(aws_s3_bucket.frontend) > 0 ? aws_s3_bucket.frontend[0].arn : null
}

output "cdn_logs_bucket_name" {
  description = "The name of the S3 bucket"
  value       = length(aws_s3_bucket.cdn_logs) > 0 ? aws_s3_bucket.cdn_logs.bucket : null
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = length(aws_s3_bucket.frontend) > 0 ? aws_s3_bucket.frontend[0].bucket_regional_domain_name : null
}

# output "s3_state_bucket_name" {
#   description = "The name of the S3 bucket"
#   value       = aws_s3_bucket.s3_state.bucket
# }

output "target_origin_id" {
  description = "The target origin ID"
  value       = aws_s3_bucket.frontend[0].bucket_regional_domain_name
}