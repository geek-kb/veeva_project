output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_azs" {
  description = "The availability zones of the created subnets"
  value       = [for s in aws_subnet.private : s.availability_zone]
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "vpc_name" {
  description = "The name of the VPC"
  value       = var.vpc_name
}

# Public Subnet IDs
output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = [for s in values(aws_subnet.public) : s.id]
}

# Public Subnet CIDR Blocks
output "public_subnet_cidr_blocks" {
  description = "The CIDR blocks of the public subnets"
  value       = [for s in values(aws_subnet.public) : s.cidr_block]
}

# Private Subnet IDs
output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = [for s in values(aws_subnet.private) : s.id]
}

# Private Subnet CIDR Blocks
output "private_subnet_cidr_blocks" {
  description = "The CIDR blocks of the private subnets"
  value       = [for s in values(aws_subnet.private) : s.cidr_block]
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.main.id
}