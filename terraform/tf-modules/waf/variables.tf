variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

variable "cloudfront_arn" {
  description = "The ARN of the CloudFront distribution to associate with the WAF"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}
