# Environment: Staging
variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# VPC
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

# S3
# variable "cloudfront_distribution_origin_domain_name" {
#   description = "The domain name of the origin"
#   type        = string
# }
# variable "cloudfront_distribution_domain_name" {
#   description = "The domain name of the CloudFront distribution"
#   type        = string
# }
variable "cloudfront_distribution_create_bucket" {
  description = "Whether to create the S3 bucket"
  type        = bool
  
}
variable "cloudfront_distribution_s3_bucket_acl" {
  description = "The ACL for the S3 bucket"
  type        = string
}

variable "cloudfront_distribution_s3_routing_rules" {
  description = "Routing rules for the S3 bucket website configuration"
  type        = string
  default     = <<EOT
[
  {
    "Condition": {
      "KeyPrefixEquals": "images/"
    },
    "Redirect": {
      "ReplaceKeyWith": "images/"
    }
  },
  {
    "Condition": {
      "KeyPrefixEquals": "videos/"
    },
    "Redirect": {
      "ReplaceKeyWith": "videos/"
    }
  }
]
EOT
}

variable "cdn_logs_retention_days" {
  description = "Retention period for CloudWatch logs"
  type        = number
}

variable "cdn_logs_bucket_name" {
  description = "The name of the S3 bucket for CDN logs"
  type        = string
}

variable "cdn_logs_bucket_routing_rules" {
  description = "Routing rules for the CDN logs bucket S3 website configuration"
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
      "ReplaceKeyPrefixWith": "monthly/"
    }
  }
]
EOT
}

variable "cdn_logs_s3_bucket_acl" {
  description = "The ACL for the S3 bucket"
  type        = string
}

variable "cloudfront_distribution_s3_force_destroy" {
  description = "Whether to delete all objects in the bucket before destroying it"
  type        = bool
  default     = true
}

variable "cdn_logs_bucket_force_destroy" {
  description = "Whether to delete all objects in the bucket before destroying it"
  type        = bool
  default     = true
}
# variable "cloudfront_distribution_s3_bucket_arn" {
#   description = "ARN of the S3 bucket for frontend"
#   type        = string
#   default     = "arn:aws:s3:::TBC"
# }

# variable "cloudfront_distribution_s3_bucket_id" {
#   description = "ID of the S3 bucket for frontend"
#   type        = string
#   default     = "TBC"
# }

# variable "lambda_function_name" {
#   description = "Name of the Lambda function for the backend"
#   type        = string
# }

# variable "api_gateway_name" {
#   description = "Name of the API Gateway for the backend"
#   type        = string
# }

# variable "environment" {
#   description = "The environment for the bucket (e.g., dev, prod)"
#   type        = string
# }

# Route 53
variable "cloudfront_hosted_zone_id" {
  description = "The ID of the Route 53 hosted zone"
  type        = string
}

variable "r53_domain_name" {
  description = "The domain name for the Route 53 record"
  type        = string
}

# SNS
variable "sns_notification_email" {
  description = "Email address to subscribe to the SNS topic"
  type        = string
}

# Lambda

variable "lambda_cloudfront_invalidation_paths" {
  description = "The list of paths to invalidate (e.g., ['/index.html', '/*'])"
  type        = list(string)
}

variable "lambda_cloudfront_invalidation_schedule_expression" {
  description = "The schedule expression for the Lambda function"
  type        = string
}

variable "lambda_cloudfront_invalidation_filename" {
  description = "The filename for the Lambda function"
  type        = string
}

# RDS

variable "rds_db_name" {
  description = "The name of the RDS database"
  type        = string
}

variable "rds_db_password" {
  description = "The password for the RDS database"
  type        = string
}

variable "rds_db_username" {
  description = "The username for the RDS database"
  type        = string
}

variable "rds_instance_class" {
  description = "The instance class for the RDS database"
  type        = string
}

variable "rds_engine_version" {
  description = "The engine version for the RDS database"
  type        = string
}

#EKS 
variable "eks_worker_instance_types" {
  description = "The instance types for the EKS worker nodes"
  type        = list(string)
}

variable "eks_worker_min_capacity" {
  description = "The minimum capacity for the EKS worker nodes"
  type        = number
}

variable "eks_worker_desired_capacity" {
  description = "The desired capacity for the EKS worker nodes"
  type        = number
}

variable "eks_worker_max_capacity" {
  description = "The maximum capacity for the EKS worker nodes"
  type        = number
}