# Terraform Module: IAM Policy for S3 Bucket and DynamoDB Table Access

This module provides resources to manage IAM policies and roles required for accessing S3 buckets and DynamoDB tables. It includes configuration for Terraform state management.

## Resources

### IAM Policy
- **S3 Bucket Access**: Grants permissions for managing objects and accessing the S3 bucket.
- **DynamoDB Table Access**: Grants permissions for interacting with the DynamoDB table used for state locking.

### IAM Role
- **Terraform State Role**: IAM role with permissions to manage the S3 bucket and DynamoDB table for Terraform state.

### Policy Attachment
- **Attach Policy to Role**: Attaches the defined IAM policy to the Terraform state role.

## Inputs

| Name                     | Description                                      | Type        | Default  | Required |
|--------------------------|--------------------------------------------------|-------------|----------|----------|
| `aws_region`             | AWS region for deployment                       | `string`    | -        | Yes      |
| `aws_account_id`         | AWS account ID                                  | `string`    | -        | Yes      |
| `bucket_name`            | Name of the S3 bucket                           | `string`    | -        | Yes      |
| `dynamodb_table_name`    | Name of the DynamoDB table                      | `string`    | -        | Yes      |
| `tags`                   | Tags to apply to all resources                  | `map(string)` | `{}`   | No       |

## Outputs

| Name                              | Description                                      |
|-----------------------------------|--------------------------------------------------|
| `terraform_state_role_arn`        | The ARN of the IAM role for Terraform state      |
| `s3_bucket_policy_arn`            | The ARN of the S3 bucket access policy          |
| `dynamodb_table_policy_arn`       | The ARN of the DynamoDB table access policy     |

## Example Usage

```hcl
module "iam_policy" {
  source = "./iam_policy"

  aws_region         = "us-west-2"
  aws_account_id     = "123456789012"
  bucket_name        = "my-terraform-state-bucket"
  dynamodb_table_name = "terraform-state-locks"

  tags = {
    Project = "Example"
    Owner   = "DevOps Team"
  }
}
