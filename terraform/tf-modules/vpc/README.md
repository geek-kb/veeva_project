# Terraform Module: VPC Configuration

This module provides resources to configure a Virtual Private Cloud (VPC) and associated networking components in AWS. It includes public and private subnets, route tables, internet gateway, NAT gateway, and Network ACLs (NACLs).

## Resources

### VPC
- **Resource**: `aws_vpc.main`
  - Creates the primary VPC with the specified CIDR block and tags.

### Security Groups
- **Default Security Group**: `aws_security_group.default`
  - Default security group for the VPC.
- **Lambda Security Group**: `aws_security_group.lambda`
  - Security group for Lambda resources.
- **Backend Security Group**: `aws_security_group.backend`
  - Security group for backend services.

### Subnets
- **Private Subnets**: `aws_subnet.private`
  - Private subnets created in all available availability zones.
- **Public Subnets**: `aws_subnet.public`
  - Public subnets with internet access, created in all available availability zones.

### Internet Gateway
- **Resource**: `aws_internet_gateway.main`
  - Provides internet access to public subnets.

### NAT Gateway
- **Resource**: `aws_nat_gateway.main`
  - Allows private subnets to access the internet through NAT.
- **Elastic IP**: `aws_eip.nat`
  - Allocates an Elastic IP for the NAT gateway.

### Route Tables
- **Public Route Table**: `aws_route_table.public`
  - Manages routes for public subnets.
- **Private Route Table**: `aws_route_table.private`
  - Manages routes for private subnets.
- **Associations**: Route tables are associated with the respective subnets.

### Network ACLs (NACLs)
- **Private NACL**: `aws_network_acl.private`
  - Controls traffic for private subnets.
- **Public NACL**: `aws_network_acl.public`
  - Controls traffic for public subnets.
- **Inbound and Outbound Rules**: Configured for both private and public subnets.

## Inputs

| Name                     | Description                                             | Type        | Default          | Required |
|--------------------------|---------------------------------------------------------|-------------|------------------|----------|
| `aws_region`             | AWS region for deployment                               | `string`    | -                | Yes      |
| `vpc_cidr_block`         | The CIDR block for the VPC                             | `string`    | -                | Yes      |
| `vpc_name`               | The name of the VPC                                    | `string`    | -                | Yes      |
| `tags`                   | A map of tags to apply to resources                    | `map(string)` | `{}`            | No       |

## Outputs

| Name                          | Description                                    |
|-------------------------------|------------------------------------------------|
| `vpc_id`                      | The ID of the VPC                             |
| `vpc_cidr_block`              | The CIDR block of the VPC                     |
| `vpc_name`                    | The name of the VPC                           |
| `subnet_azs`                  | The availability zones of the created subnets |
| `public_subnet_ids`           | The IDs of the public subnets                 |
| `public_subnet_cidr_blocks`   | The CIDR blocks of the public subnets         |
| `private_subnet_ids`          | The IDs of the private subnets                |
| `private_subnet_cidr_blocks`  | The CIDR blocks of the private subnets        |
| `internet_gateway_id`         | The ID of the Internet Gateway                |
| `nat_gateway_id`              | The ID of the NAT Gateway                     |

## Example Usage

```hcl
module "vpc" {
  source = "./vpc"

  aws_region      = "us-west-2"
  vpc_cidr_block  = "10.0.0.0/16"
  vpc_name        = "my-vpc"

  tags = {
    Project = "Example"
    Owner   = "DevOps Team"
  }
}
