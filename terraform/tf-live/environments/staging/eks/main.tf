
module "eks_example_eks-auto-mode" {
  source  = "terraform-aws-modules/eks/aws//examples/eks-auto-mode"
  version = "20.31.6"
 
  cluster_name   = local.cluster_name
  cluster_version = local.cluster_version
  aws_region     = local.aws_region
  cluster_min_size = local.cluster_min_size
  cluster_max_size = local.cluster_max_size
  cluster_desired_capacity = local.cluster_desired_capacity
  cluster_key_name = local.cluster_key_name
  cluster_public_key = local.cluster_public_key
  cluster_vpc_id = local.cluster_vpc_id
}