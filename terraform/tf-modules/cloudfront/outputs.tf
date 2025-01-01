output "frontend_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.frontend.domain_name
}

output "frontend_hosted_zone_id" {
  description = "The hosted zone ID for the CloudFront distribution"
  value       = aws_cloudfront_distribution.frontend.hosted_zone_id
}

output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.frontend.id
}

output "cloudfront_distribution_arn" {
  description = "The ARN of the CloudFront distribution"
  value       = aws_cloudfront_distribution.frontend.arn
}

# output "cloudfront_distribution_bucket_name" {
#   description = "The name of the S3 bucket for cloudfront frontend"
#   value       = aws_cloudfront_distribution.frontend.bucket_name
# }

# output "cloudfront_distribution_endpoint" {
#   description = "The domain name of the CloudFront distribution"
#   value       = aws_cloudfront_distribution.frontend.domain_name
# }

output "cdn_logs_bucket_name" {
  description = "The name of the S3 bucket for CDN logs"
  value       = aws_s3_bucket.cdn_logs.bucket
}
