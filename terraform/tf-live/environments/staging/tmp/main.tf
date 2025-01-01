# Define reusable local values
locals {
  environment = terraform.workspace
  project     = var.project_name
  owner       = "itaig"

  tags = {
    Environment = local.environment
    Project     = local.project
  }

  aws_region = var.aws_region
  account_id = var.aws_account_id

  # VPC
  vpc_name       = "${local.environment}-vpc"
  vpc_cidr_block = var.vpc_cidr_block

  # S3
  #cloudfront_distribution_origin_domain_name = module.s3.cloudfront_distribution_origin_domain_name
  cloudfront_distribution_create_bucket          = var.cloudfront_distribution_create_bucket
  cloudfront_distribution_bucket_name   = "${local.environment}-${local.project}-bucket"
  cloudfront_distribution_bucket_arn    = module.s3.cloudfront_distribution_bucket_arn
  cloudfront_distribution_s3_force_destroy = var.cloudfront_distribution_s3_force_destroy
  cloudfront_distribution_s3_bucket_acl = var.cloudfront_distribution_s3_bucket_acl
  cloudfront_distribution_domain_name = module.s3.cloudfront_distribution_domain_name
  cdn_logs_bucket_name = var.cdn_logs_bucket_name
  cdn_logs_bucket_force_destroy = var.cdn_logs_bucket_force_destroy
  cdn_logs_retention_days = var.cdn_logs_retention_days
  cdn_logs_s3_bucket_acl = var.cloudfront_distribution_s3_bucket_acl



  # Route53
  r53_domain_name = var.r53_domain_name
  # CloudFront
  target_origin_id                = "S3-${local.environment}-${local.project}-bucket"
  cf_domain_name                  = local.r53_domain_name
  cloudfront_hosted_zone_id       = var.cloudfront_hosted_zone_id
  cloudfront_distribution_bucket_id = module.s3.cloudfront_distribution_bucket_id
  #cloudfront_invalidation_paths = var.cloudfront_invalidation_paths
  #lambda_cloudfront_invalidation_filename = var.lambda_cloudfront_invalidation_filename
  #lambda_cloudfront_invalidation_schedule_expression = var.lambda_cloudfront_invalidation_schedule_expression

  # SNS
  sns_notification_email = var.sns_notification_email
  sns_topic_name         = "${local.environment}-${local.project}-topic"

#   # CloudWatch
#   cdn_logs_retention_days       = local.cdn_logs_retention_days
#   cdn_logs_bucket_force_destroy = var.cdn_logs_bucket_force_destroy

  # Lambda
  lambda_cloudfront_invalidation_filename            = var.lambda_cloudfront_invalidation_filename
  lambda_cloudfront_invalidation_schedule_expression = var.lambda_cloudfront_invalidation_schedule_expression
  lambda_cloudfront_invalidation_paths               = var.lambda_cloudfront_invalidation_paths
  api_gateway_name                                   = "${local.environment}-${local.project}"

  # RDS
  rds_db_name        = var.rds_db_name
  rds_db_password    = var.rds_db_password
  rds_db_username    = var.rds_db_username
  rds_instance_class = var.rds_instance_class
  rds_engine_version = var.rds_engine_version

# EKS
    eks_cluster_name = "${local.environment}-${local.project}-cluster"
    eks_worker_instance_types = var.eks_worker_instance_types
    eks_worker_min_capacity = var.eks_worker_min_capacity
    eks_worker_desired_capacity = var.eks_worker_desired_capacity
    eks_worker_max_capacity = var.eks_worker_max_capacity

  # # IAM
  # iam_policy_name = "${local.environment}-${local.project}-policy"
  # iam_role_name = "${local.environment}-${local.project}-role"
  # iam_instance_profile_name = "${local.environment}-${local.project}-instance-profile"
  # iam_lambda_policy_name = "${local.environment}-${local.project}-lambda-policy"
  # iam_lambda_role_name = "${local.environment}-${local.project}-lambda-role"

  # security_group_ingress_rules = [
  #     {
  #     description = "Allow HTTP"
  #     from_port   = 80
  #     to_port     = 80
  #     protocol    = "tcp"
  #     cidr_blocks = ["0.0.0.0/0"]
  #     },
  #     {
  #     description = "Allow SSH"
  #     from_port   = 22
  #     to_port     = 22
  #     protocol    = "tcp"
  #     cidr_blocks = ["0.0.0.0/0"]
  #     }
  # ]

  common_tags = merge(var.common_tags, local.tags)

}

module "vpc" {
  source         = "../../../tf-modules/vpc"
  vpc_cidr_block = local.vpc_cidr_block
  vpc_name       = local.vpc_name
  aws_region     = local.aws_region
  tags           = local.common_tags
}

module "s3" {
  source                  = "../../../tf-modules/s3"
  cloudfront_distribution_create_bucket          = local.cloudfront_distribution_create_bucket
  cloudfront_distribution_bucket_name             = local.cloudfront_distribution_bucket_name
  cloudfront_distribution_force_destroy           = local.cloudfront_distribution_s3_force_destroy
  cloudfront_distribution_s3_bucket_acl = local.cloudfront_distribution_s3_bucket_acl
  environment             = local.environment
  cdn_logs_bucket_name = local.cdn_logs_bucket_name
  cdn_logs_retention_days = local.cdn_logs_retention_days
}

module "cloudfront" {
  source                        = "../../../tf-modules/cloudfront"
  cloudfront_distribution_create_bucket = local.cloudfront_distribution_create_bucket
  cloudfront_distribution_website_endpoint = module.s3.cloudfront_distribution_website_endpoint
  cloudfront_distribution_bucket_id = local.cloudfront_distribution_bucket_id
  cloudfront_distribution_bucket_name = local.cloudfront_distribution_bucket_name
  cloudfront_distribution_bucket_arn = local.cloudfront_distribution_bucket_arn
  cloudfront_distribution_domain_name = local.cloudfront_distribution_domain_name
  environment                   = local.environment
  common_tags                   = local.common_tags
  target_origin_id              = local.target_origin_id
#cloudfront_distribution_origin_domain_name = local.cloudfront_distribution_origin_domain_name
}

# module "route53" {
#   source                    = "../../../tf-modules/route53"
#   domain_name               = local.r53_domain_name
#   bucket_name               = local.cloudfront_distribution_bucket_name
#   environment               = local.environment
#   common_tags               = local.common_tags
#   cloudfront_hosted_zone_id = local.cloudfront_hosted_zone_id

#   # To be fixed later as it causes dependency to cloudfront module
#   cloudfront_domain_name = module.cloudfront.frontend_domain_name
# }

# # module "iam" {
# # source        = "./modules/compute/frontend/iam"
# # s3_bucket_arn = module.s3.bucket_arn
# # environment   = var.environment
# # common_tags   = var.common_tags
# # }

# module "sns" {
#   source             = "../../../tf-modules/sns"
#   environment        = local.environment
#   aws_account_id     = local.account_id
#   common_tags        = local.common_tags
#   notification_email = local.sns_notification_email
# }

# # module "cloudwatch" {
# #   source                     = "../../../tf-modules/cloudwatch"
# #   cloudfront_distribution_id = module.cloudfront.cloudfront_distribution_id
# #   region                     = local.aws_region
# #   environment                = local.environment
# #   log_retention_days         = local.cdn_logs_retention_days
# #   notification_topic_arn     = "arn:aws:sns:${local.aws_region}:${local.account_id}:${local.sns_topic_name}"
# #   common_tags                = var.common_tags
# #   cdn_logs_bucket_name       = var.cdn_logs_bucket_name
# #   cdn_logs_retention_days    = var.cdn_logs_retention_days
# # }

# module "waf" {
#   source         = "../../../tf-modules/waf"
#   environment    = local.environment
#   cloudfront_arn = module.cloudfront.cloudfront_distribution_arn
#   common_tags    = local.common_tags
# }

# module "lambda_cloudfront_invalidation" {
#   source                     = "../../../tf-modules/lambda/cdn-invalidation"
#   cloudfront_distribution_id = module.cloudfront.cloudfront_distribution_id
#   invalidation_paths         = local.lambda_cloudfront_invalidation_paths
#   environment                = local.environment
#   aws_account_id             = local.account_id
#   common_tags                = local.common_tags
#   lambda_zip_file            = local.lambda_cloudfront_invalidation_filename
#   lambda_schedule_expression = local.lambda_cloudfront_invalidation_schedule_expression
#   bucket_name                = local.cloudfront_distribution_bucket_name
# }

# module "rds" {
#   source                  = "../../../tf-modules/rds"
#   environment             = local.environment
#   vpc_id                  = module.vpc.vpc_id
#   subnet_ids              = module.vpc.private_subnet_ids
#   allowed_cidr_blocks     = toset(module.vpc.private_subnet_cidr_blocks)
#   db_name                 = local.rds_db_name
#   db_username             = local.rds_db_username
#   db_password             = local.rds_db_password
#   engine_version          = local.rds_engine_version
#   instance_class          = local.rds_instance_class
#   allocated_storage       = 20
#   max_allocated_storage   = 100
#   multi_az                = false
#   publicly_accessible     = false
#   backup_retention_period = 7
#   tags = {
#     Project = local.project
#     Owner   = local.owner
#   }
# }

# # module "eks" {
# #   source = "../../../tf-modules/eks"

# #   cluster_name      = "${local.environment}-${local.project}-cluster"
# #   vpc_id            = module.vpc.vpc_id
# #   vpc_cidr          = module.vpc.vpc_cidr
# #   subnet_ids        = module.vpc.private_subnet_ids
# #   worker_instance_types = var.eks_worker_instance_types
# #   worker_min_capacity   = var.eks_worker_min_capacity
# #   worker_desired_capacity = var.eks_worker_desired_capacity
# #   worker_max_capacity   = var.eks_worker_max_capacity

# #   tags = {
# #     Project = local.project
# #     Owner   = local.owner
# #   }

# #   environment = local.environment
# # }

# # module "ssm" {
# #   source = "../../../tf-modules/ssm"

# #   environment = local.environment
# #   tags = {
# #     Project = local.project
# #     Owner   = local.owner
# #   }

# #   ssm_parameters = {
# #     "/app/database/password" = {
# #       type        = "SecureString"
# #       value       = module.rds.rds_db_password
# #       description = "Database password for the app"
# #     }
# #     "/app/api/token" = {
# #       type        = "String"
# #       value       = "myapitoken"
# #       description = "API token for the app"
# #     }
# #   }

# #   enable_patch_baseline        = true
# #   patch_baseline_operating_system = "AMAZON_LINUX"
# #   patch_baseline_product       = ["AmazonLinux2"]
# #   patch_approval_days          = 7
# # }
