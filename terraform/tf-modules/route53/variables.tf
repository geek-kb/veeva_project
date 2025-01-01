variable "domain_name" {
  description = "The domain name for the Route 53 record"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket for the frontend"
  type        = string
}

variable "environment" {
  description = "The environment for the bucket (e.g., dev, prod)"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "cloudfront_hosted_zone_id" {
  description = "The ID of the Route 53 hosted zone"
  type        = string
}

variable "cloudfront_domain_name" {
  description = "The domain name for the Route 53 record"
  type        = string
}