variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

variable "ssm_parameters" {
  description = "A map of SSM parameters to create"
  type = map(object({
    type        = string
    value       = string
    description = string
    tier        = optional(string, "Standard") # Standard or Advanced
    overwrite   = optional(bool, false)
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# Enable Patch Baseline
variable "enable_patch_baseline" {
  description = "Whether to create a patch baseline"
  type        = bool
  default     = false
}

variable "patch_baseline_operating_system" {
  description = "The operating system for the patch baseline (e.g., AMAZON_LINUX, WINDOWS)"
  type        = string
  default     = "AMAZON_LINUX"
}

variable "patch_baseline_product" {
  description = "The product filter for the patch baseline (e.g., AmazonLinux2)"
  type        = list(string)
  default     = ["AmazonLinux2"]
}

variable "patch_approval_days" {
  description = "Number of days after release to approve patches"
  type        = number
  default     = 7
}
