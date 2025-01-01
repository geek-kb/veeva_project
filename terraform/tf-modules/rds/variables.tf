variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the RDS instance"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the RDS instance"
  type        = list(string)
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_username" {
  description = "The master username for the database"
  type        = string
}

variable "db_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string
}

variable "instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "The initial allocated storage (in GB)"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "The maximum allocated storage (in GB)"
  type        = number
  default     = 100
}

variable "parameter_group_name" {
  description = "The name of the parameter group to associate with the RDS instance"
  type        = string
  default     = null
}

variable "multi_az" {
  description = "Specifies whether the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "storage_type" {
  description = "The storage type for the RDS instance (e.g., standard, gp2, io1)"
  type        = string
  default     = "gp2"
}

variable "backup_retention_period" {
  description = "The number of days to retain backups"
  type        = number
  default     = 7
}

variable "publicly_accessible" {
  description = "Whether the RDS instance is publicly accessible"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Whether to skip taking a final snapshot before destroying the instance"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}
