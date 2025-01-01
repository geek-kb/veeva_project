output "waf_web_acl_arn" {
  description = "The ARN of the WAF Web ACL"
  value       = aws_wafv2_web_acl.frontend_waf.arn
}

output "waf_web_acl_id" {
  description = "The ID of the WAF Web ACL"
  value       = aws_wafv2_web_acl.frontend_waf.id
}

output "waf_log_bucket_arn" {
  description = "The ARN of the S3 bucket used for WAF logs"
  value       = aws_s3_bucket.waf_logs.arn
}
