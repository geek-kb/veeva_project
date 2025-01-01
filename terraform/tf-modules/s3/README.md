# Terraform Module: S3 Configuration

This module provides resources to configure Amazon S3 buckets for frontend hosting and CDN logs.

## Resources

### S3 Buckets
- **Frontend Bucket**: `aws_s3_bucket.frontend`
  - Creates an S3 bucket for frontend hosting.
  - Configures public access block and routing rules.

- **CDN Logs Bucket**: `aws_s3_bucket.cdn_logs`
  - Creates an S3 bucket for storing CDN logs.

### Bucket Policies
- **Frontend Bucket Policy**: `aws_s3_bucket_policy.frontend`
  - Restricts access to the bucket using IAM and Origin Access Identity (OAI).

- **CDN Logs Bucket Policy**: `aws_s3_bucket_policy.cdn_logs_policy`
  - Allows CloudFront to write logs to the bucket.

### Bucket Lifecycle Policy
- **CDN Logs Lifecycle**: `aws_s3_bucket_lifecycle_configuration.cdn_logs_lifecycle`
  - Configures lifecycle rules for log retention.

## Inputs

| Name                                | Description                                               | Type        | Default | Required |
|-------------------------------------|-----------------------------------------------------------|-------------|---------|----------|
| `environment`                       | Environment for the buckets (e.g., dev, prod)             | `string`    | -       | Yes      |
| `cloudfront_distribution_bucket_id` | ID of the S3 bucket for frontend hosting                  | `string`    | -       | Yes      |
| `cloudfront_distribution_bucket_name` | Name of the S3 bucket for frontend hosting               | `string`    | -       | Yes      |
| `cdn_logs_bucket_name`              | Name of the S3 bucket for CDN logs                       | `string`    | -       | Yes      |
| `cdn_logs_bucket_force_destroy`     | Whether to force destroy the CDN logs bucket             | `bool`      | `true`  | No       |
| `cdn_logs_retention_days`           | Number of days to retain logs in the CDN logs bucket      | `number`    | -       | Yes      |
| `common_tags`                       | Common tags to apply to all resources                    | `map(string)` | `{}`  | No       |

## Outputs

| Name                              | Description                              |
|-----------------------------------|------------------------------------------|
| `cloudfront_distribution_bucket_name` | Name of the frontend S3 bucket         |
| `cloudfront_distribution_bucket_id`   | ID of the frontend S3 bucket           |
| `cloudfront_distribution_bucket_arn`  | ARN of the frontend S3 bucket          |
| `cdn_logs_bucket_name`            | Name of the CDN logs S3 bucket           |
| `cloudfront_distribution_domain_name` | Domain name of the CloudFront distribution |

## Example Usage

```hcl
module "s3" {
  source = "./s3"

  environment                       = "staging"
  cloudfront_distribution_bucket_id = "frontend-bucket-id"
  cloudfront_distribution_bucket_name = "frontend-bucket"
  cdn_logs_bucket_name              = "cdn-logs-bucket"
  cdn_logs_retention_days           = 90

  common_tags = {
    Project = "Example"
    Owner   = "DevOps Team"
  }
}
