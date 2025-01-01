variable "environment" {
  description = "The environment for the SNS topic (e.g., dev, staging, prod)"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "notification_email" {
  description = "Email address to subscribe to the SNS topic"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

