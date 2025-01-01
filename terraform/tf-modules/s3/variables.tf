variable "environment" {
  description = "The environment for the bucket (e.g., dev, prod)"
  type        = string
}

variable "aws_account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "aws_region" {
  description = "The AWS region"
  type        = string
}

# Cloudfront Distribution
variable "cloudfront_distribution_create_bucket" {
  description = "Whether to create the S3 bucket"
  type        = bool
}

variable "cloudfront_distribution_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "cloudfront_distribution_force_destroy" {
  description = "Whether to force destroy the bucket (true for dev)"
  type        = bool
}

variable "cloudfront_distribution_s3_bucket_acl" {
  description = "The ACL for the S3 bucket"
  type        = string
}

variable "cloudfront_distribution_bucket_routing_rules" {
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

# variable "cloudfront_distribution_bucket_website_endpoint" {
#   description = "The website endpoint of the bucket"
#   type        = string
# }

# CDN Logs

variable "cdn_logs_bucket_name" {
  description = "The name of the S3 bucket for CDN logs"
  type        = string
}

variable "cdn_logs_bucket_force_destroy" {
  description = "Whether to delete all objects in the bucket before destroying it"
  type        = bool
  default     = true
}

variable "cdn_logs_s3_bucket_acl" {
  description = "The ACL for the S3 bucket"
  type        = string
  default     = "private"
}

variable "cdn_logs_bucket_routing_rules" {
  description = "Routing rules for the cdn_logs bucket"
  type        = string
  default     = <<EOT
[
  {
    "Condition": {
      "KeyPrefixEquals": "logs/"
    },
    "Redirect": {
      "ReplaceKeyPrefixWith": "archive/logs/"
    }
  },
  {
    "Condition": {
      "HttpErrorCodeReturnedEquals": "404"
    },
    "Redirect": {
      "ReplaceKeyWith": "error.html"
    }
  },
  {
    "Condition": {
      "KeyPrefixEquals": "reports/"
    },
    "Redirect": {
      "Protocol": "https",
      "ReplaceKeyPrefixWith": "reports/"
    }
  }
]
EOT
}

variable "cdn_logs_retention_days" {
  description = "The number of days to retain the logs"
  type        = number
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
