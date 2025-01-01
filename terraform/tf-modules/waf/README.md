# Terraform Module: WAF Configuration

This module provides resources to configure a Web Application Firewall (WAF) for a frontend application, including logging and association with a CloudFront distribution.

## Resources

### WAF Web ACL
- **Resource**: `aws_wafv2_web_acl.frontend_waf`
  - Creates a WAF Web ACL with managed rule sets for the frontend application.

### WAF Web ACL Association
- **Resource**: `aws_wafv2_web_acl_association.frontend_waf_association`
  - Associates the WAF Web ACL with a CloudFront distribution.

### S3 Bucket for WAF Logs
- **Resource**: `aws_s3_bucket.waf_logs`
  - Creates an S3 bucket to store WAF logs.
- **Resource**: `aws_s3_bucket_policy.waf_logs_policy`
  - Configures the bucket policy to allow WAF logging.

### WAF Logging Configuration
- **Resource**: `aws_wafv2_web_acl_logging_configuration.waf_logging`
  - Configures WAF to log requests to the S3 bucket.

## Inputs

| Name              | Description                                                | Type        | Default  | Required |
|-------------------|------------------------------------------------------------|-------------|----------|----------|
| `environment`     | The environment (e.g., dev, staging, prod)                 | `string`    | -        | Yes      |
| `cloudfront_arn`  | The ARN of the CloudFront distribution to associate with WAF | `string`    | -        | Yes      |
| `common_tags`     | Common tags for all resources                              | `map(string)` | `{}`    | No       |

## Outputs

| Name                 | Description                                      |
|----------------------|--------------------------------------------------|
| `waf_web_acl_arn`    | The ARN of the WAF Web ACL                      |
| `waf_web_acl_id`     | The ID of the WAF Web ACL                       |
| `waf_log_bucket_arn` | The ARN of the S3 bucket used for WAF logs      |

## Example Usage

```hcl
module "waf" {
  source          = "./waf"

  environment     = "staging"
  cloudfront_arn  = "arn:aws:cloudfront::123456789012:distribution/EXAMPLE"

  common_tags = {
    Project = "Example"
    Owner   = "DevOps Team"
  }
}
