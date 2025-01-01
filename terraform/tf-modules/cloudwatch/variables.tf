variable "environment" {
  description = "The environment for the bucket (e.g., dev, prod)"
  type        = string
  default     = "staging"
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  type        = string
}

variable "region" {
  description = "The AWS region for monitoring resources"
  type        = string
}

variable "log_retention_days" {
  description = "Retention period for CloudWatch logs"
  type        = number
}

variable "notification_topic_arn" {
  description = "ARN of the SNS topic for alarms"
  type        = string
}

variable "cdn_logs_bucket_name" {
  description = "The name of the S3 bucket for CDN logs"
  type        = string
}

variable "cdn_logs_retention_days" {
  description = "The number of days to retain the logs"
  type        = number
}