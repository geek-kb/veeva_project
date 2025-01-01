
# Route 53 Record Terraform Module

This module creates an Amazon Route 53 DNS record to point to an AWS CloudFront distribution. The module manages the record's configuration and ensures integration with CloudFront.

## Resources

- **Route 53 Record**: Creates an `A` record in Route 53 with alias settings pointing to a CloudFront distribution.

## Inputs

| Variable Name             | Description                                    | Type        | Default     |
|---------------------------|------------------------------------------------|-------------|-------------|
| `domain_name`             | The domain name for the Route 53 record.       | `string`    | N/A         |
| `bucket_name`             | Name of the S3 bucket for the frontend.        | `string`    | N/A         |
| `environment`             | The environment for the bucket (e.g., dev, prod). | `string`    | N/A         |
| `common_tags`             | Common tags to apply to all resources.         | `map(string)` | `{}`      |
| `cloudfront_hosted_zone_id` | The ID of the Route 53 hosted zone.           | `string`    | N/A         |
| `cloudfront_domain_name`  | The domain name for the Route 53 record.       | `string`    | N/A         |

## Outputs

| Output Name               | Description                                    |
|---------------------------|------------------------------------------------|
| `route53_record_name`     | The name of the Route 53 record.               |
| `route53_record_fqdn`     | The fully qualified domain name of the Route 53 record. |
| `cloudfront_hosted_zone_id` | The ID of the Route 53 hosted zone.           |

## Example Usage

```hcl
module "route53_record" {
  source                   = "./path-to-module"
  domain_name              = "example.com"
  bucket_name              = "my-frontend-bucket"
  environment              = "prod"
  common_tags              = {
    Team  = "DevOps"
    Owner = "Admin"
  }
  cloudfront_hosted_zone_id = "Z2FDTNDATAQYW2"
  cloudfront_domain_name   = "d1234567890.cloudfront.net"
}
```
