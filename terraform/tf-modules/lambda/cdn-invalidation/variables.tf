variable "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
  default     = "staging"
}

variable "aws_account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

variable "lambda_schedule_expression" {
  description = "The schedule expression for the Lambda function"
  type        = string
}

variable "lambda_zip_file" {
  description = "Path to the Lambda ZIP file"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "invalidation_paths" {
  description = "The list of paths to invalidate (e.g., ['/index.html', '/*'])"
  type        = list(string)
}

variable "cdn_logs_bucket_force_destroy" {
  description = "Whether to delete all objects in the bucket before destroying it"
  type        = bool
  default     = true
}