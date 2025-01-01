# output "outputs" {
#   description = "The name of the S3 bucket"
#   value       = module.s3
# }

output "cloudfront_distribution_website_endpoint" {
  description = "The S3 bucket website endpoint"
  value       = module.s3.cloudfront_distribution_website_endpoint
}

output "cloudfront_distribution_bucket_name" {
  description = "The name of the S3 bucket"
  value       = module.s3.cloudfront_distribution_bucket_name
}

output "cloudfront_distribution_bucket_id" {
  description = "The ID of the S3 bucket"
  value       = module.s3.cloudfront_distribution_bucket_id
}

output "cloudfront_distribution_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3.cloudfront_distribution_bucket_arn
}

output "cdn_logs_bucket_name" {
  description = "The name of the S3 bucket"
  value       = module.s3.cdn_logs_bucket_name
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = module.s3.cloudfront_distribution_domain_name
}
