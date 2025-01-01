# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_cidr_blocks" {
  description = "The CIDR blocks of the public subnets"
  value       = module.vpc.public_subnet_cidr_blocks
}

output "private_subnet_cidr_blocks" {
  description = "The CIDR blocks of the private subnets"
  value       = module.vpc.private_subnet_cidr_blocks
}

output "subnet_azs" {
  description = "The availability zones of the created subnets"
  value       = module.vpc.subnet_azs
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "vpc_name" {
  description = "The name of the VPC"
  value       = module.vpc.vpc_name
}

output "environment" {
  description = "The environment for the bucket"
  value       = local.environment
}

output "project_name" {
  description = "The name of the project"
  value       = local.project
}

# S3
output "cloudfront_distribution_bucket_name" {
  description = "The name of the S3 bucket"
  value       = local.cloudfront_distribution_bucket_name
}

output "bucket_website_endpoint" {
  description = "The S3 bucket website endpoint"
  value       = module.s3.cloudfront_distribution_website_endpoint
}

output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = module.s3.cloudfront_distribution_bucket_id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3.cloudfront_distribution_bucket_arn
}

# # Route 53
# output "cloudfront_hosted_zone_id" {
#   description = "The ID of the Route 53 hosted zone"
#   value       = module.route53.cloudfront_hosted_zone_id
# }

# output "route53_record_name" {
#   description = "The name of the Route 53 record"
#   value       = module.route53.route53_record_name
# }

# output "route53_record_fqdn" {
#   description = "The fully qualified domain name of the Route 53 record"
#   value       = module.route53.route53_record_fqdn
# }

# # CloudFront
# output "frontend_domain_name" {
#   description = "The domain name of the CloudFront distribution"
#   value       = module.cloudfront.frontend_domain_name
# }

# output "frontend_hosted_zone_id" {
#   description = "The hosted zone ID for the CloudFront distribution"
#   value       = module.cloudfront.frontend_hosted_zone_id
# }

# output "cloudfront_distribution_id" {
#   description = "The ID of the CloudFront distribution"
#   value       = module.cloudfront.cloudfront_distribution_id
# }

# output "cloudfront_distribution_arn" {
#   description = "The ARN of the CloudFront distribution"
#   value       = module.cloudfront.cloudfront_distribution_arn
# }

# # Lambda
# output "lambda_function_name" {
#   description = "The name of the Lambda function"
#   value       = module.lambda_cloudfront_invalidation.lambda_function_name
# }
