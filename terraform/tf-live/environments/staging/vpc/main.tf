
module "vpc" {
  source         = "../../../../tf-modules/vpc"
  vpc_cidr_block = local.vpc_cidr_block
  vpc_name       = local.vpc_name
  aws_region     = local.aws_region
  tags           = local.common_tags
}