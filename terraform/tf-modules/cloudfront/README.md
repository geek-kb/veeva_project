
# Terraform Module for CloudFront Distribution and S3 Configuration

This Terraform module provisions a CloudFront distribution and associated resources for a frontend application. It includes S3 buckets for static assets and logs, with additional configurations for security, lifecycle, and access policies.

## Features

- CloudFront distribution with origin access control.
- S3 bucket for static assets with website hosting configuration.
- S3 bucket for CloudFront logs with lifecycle management.
- IAM policies for secure access between CloudFront and S3.
- Outputs for integration with other modules or resources.

## Resources Created

- `aws_cloudfront_origin_access_control`
- `aws_cloudfront_distribution`
- `aws_s3_bucket` (static assets and logs)
- `aws_s3_bucket_policy`
- `aws_s3_bucket_lifecycle_configuration`
- `aws_cloudfront_origin_access_identity`

## Usage

```hcl
module "cloudfront_distribution" {
  source = "./path/to/module"

  environment                             = "dev"
  cloudfront_distribution_bucket_name     = "frontend-bucket"
  cloudfront_distribution_bucket_id       = "frontend-bucket-id"
  cloudfront_distribution_bucket_arn      = "arn:aws:s3:::frontend-bucket"
  cloudfront_distribution_website_endpoint = "frontend-bucket.s3-website-us-east-1.amazonaws.com"
  cdn_logs_bucket_force_destroy           = true
  frontend_bucket_routing_rules           = <<EOT
  [
    {
      "Condition": {
        "KeyPrefixEquals": "docs/"
      },
      "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
      }
    }
  ]
  EOT

  common_tags = {
    Project     = "E-Commerce"
    Environment = "Development"
  }
}
```

## Inputs

| Variable                          | Description                                         | Type          | Default                  |
|-----------------------------------|-----------------------------------------------------|---------------|--------------------------|
| `cloudfront_distribution_bucket_name` | Name of the S3 bucket for CloudFront frontend.      | `string`      | -                        |
| `cloudfront_distribution_bucket_id`   | ID of the S3 bucket for CloudFront frontend.        | `string`      | -                        |
| `cloudfront_distribution_bucket_arn`  | ARN of the S3 bucket for CloudFront frontend.       | `string`      | -                        |
| `environment`                      | Environment (e.g., `dev`, `prod`).                 | `string`      | -                        |
| `frontend_bucket_routing_rules`    | Routing rules for bucket website configuration.    | `string`      | See example in usage.    |
| `common_tags`                      | Tags to apply to all resources.                   | `map(string)` | `{}`                     |

## Outputs

| Output                         | Description                                     |
|--------------------------------|-------------------------------------------------|
| `frontend_domain_name`          | The domain name of the CloudFront distribution.|
| `frontend_hosted_zone_id`       | The hosted zone ID for the CloudFront distribution. |
| `cloudfront_distribution_id`    | The ID of the CloudFront distribution.         |
| `cloudfront_distribution_arn`   | The ARN of the CloudFront distribution.        |
| `cdn_logs_bucket_name`          | The name of the S3 bucket for CDN logs.        |

## License

This module is licensed under the MIT License. See LICENSE for full details.
