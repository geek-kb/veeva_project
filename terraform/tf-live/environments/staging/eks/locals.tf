locals {
  aws_region     = "il-central-1"
  cluster_name   = "staging-eks"
  cluster_version = "1.31"
  cluster_vpc_id = "vpc-009c901ea0ed79fb9"
  cluster_instance_type = local.cluster_instance_type
  cluster_min_size = 1
  cluster_max_size = 1
  cluster_desired_capacity = 1
  cluster_key_name = "il-central-1-eks"
  cluster_public_key = file("~/.ssh/il-central-1-eks.pub")
  create_iam_role = false
  iam_role_arn = "arn:aws:iam::912466608750:role/AmazonEKSAutoClusterRole"
  create_node_iam_role = false
  node_iam_role_arn = "arn:aws:iam::912466608750:role/AmazonEKSAutoNodeRole"  
}

