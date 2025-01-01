variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  validation {
    condition     = can(regex("^(?:\\d{1,3}\\.){3}\\d{1,3}/\\d{1,2}$", var.vpc_cidr_block))
    error_message = "The VPC CIDR block must be a valid CIDR format."
  }
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
  default     = {}
}
