output "cloudfront_s3_access_role_arn" {
  description = "ARN of the IAM role for CloudFront to access S3"
  value       = aws_iam_role.cloudfront_s3_access.arn
}

output "cloudfront_invalidation_role_arn" {
  description = "ARN of the IAM role for CloudFront invalidation"
  value       = aws_iam_role.cloudfront_invalidation.arn
}
