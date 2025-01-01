variable "cloudfront_distribution_bucket_name" {
  description = "The name of the S3 bucket for cloudfront frontend"
  type        = string
}

variable "cloudfront_distribution_bucket_id" {
  description = "The ID of the S3 bucket for cloudfront frontend"
  type        = string
}

variable "environment" {
  description = "The environment for the bucket (e.g., dev, prod)"
  type        = string
}

variable "cloudfront_distribution_bucket_arn" {
  description = "The ARN of the S3 bucket for cloudfront frontend"
  type        = string
}
# variable "cloudfront_distribution_s3_bucket_acl" {
#   description = "The ACL for the S3 bucket"
#   type        = string
#   default     = "public-read"

# }

# variable "cloudfront_distribution_s3_force_destroy" {
#   description = "Whether to delete all objects in the bucket before destroying it"
#   type        = bool
#   default     = true
# }

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "target_origin_id" {
  description = "The ID of the origin"
  type        = string
}

variable "cloudfront_distribution_website_endpoint" {
  description = "The website endpoint of the bucket"
  type        = string
}

# variable "cdn_logs_bucket_name" {
#   description = "The name of the S3 bucket for CDN logs"
#   type        = string
# }

# variable "cdn_logs_retention_days" {
#   description = "The number of days to retain the logs"
#   type        = number
# }
variable "cloudfront_distribution_domain_name" {
  description = "The domain name of the CloudFront distribution"
  type        = string
}

variable "cdn_logs_bucket_force_destroy" {
  description = "Whether to delete all objects in the bucket before destroying it"
  type        = bool
  default     = true 
}

variable "frontend_bucket_routing_rules" {
  description = "Routing rules for the bucket website configuration"
  type        = string
  default     = <<EOT
  [
    {
      "Condition": {
        "KeyPrefixEquals": "docs/"
      },
      "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
      }
    }
  ]
  EOT
}

variable "cloudfront_frontend_bucket_force_destroy" {
  description = "Whether to delete all objects in the bucket before destroying it"
  type        = bool
  default     = true
}

# variable "cdn_logs_s3_bucket_acl" {
#   description = "The ACL for the S3 bucket"
#   type        = string
#   default     = "private"
# }


####
# variable "cloudfront_distribution_create_bucket" {
#   description = "Whether to create the S3 bucket"
#   type        = bool
# }