
# Lambda Module for CDN Invalidation

This Terraform module sets up a Lambda function for CloudFront CDN invalidation. The Lambda function invalidates specified paths in a CloudFront distribution and can optionally be triggered via a scheduled CloudWatch Event.

## Directory Structure
```
./cdn-invalidation
├── lambda_function.zip     # Zipped Lambda function code
├── main.tf                 # Main Terraform configuration
├── outputs.tf              # Outputs for the module
└── variables.tf            # Variables for the module
```

## Features
- **Lambda Function**: Configured to handle CDN invalidation for a specific CloudFront distribution.
- **IAM Roles and Policies**: Proper IAM roles and policies are set up to allow the Lambda function to perform CloudFront invalidations.
- **Optional Trigger**: Optionally, the Lambda function can be triggered periodically using a CloudWatch Event Rule.
- **Outputs**: Provides useful information such as the Lambda function name and ARN.

## Resources Created
1. **IAM Role for Lambda**: Grants permissions for the Lambda function to assume its role.
2. **IAM Policy for Lambda**: Allows the Lambda function to perform `cloudfront:CreateInvalidation`.
3. **Lambda Function**: Configures the Lambda function with specified environment variables.
4. **CloudWatch Event Rule**: (Optional) Triggers the Lambda function on a schedule.
5. **CloudWatch Event Target**: Links the CloudWatch Event Rule to the Lambda function.
6. **Lambda Permission**: Allows CloudWatch Events to invoke the Lambda function.

## Inputs
| Name                     | Description                                     | Type          | Default    |
|--------------------------|-------------------------------------------------|---------------|------------|
| `cloudfront_distribution_id` | The ID of the CloudFront distribution          | `string`      | n/a        |
| `environment`            | The environment (e.g., dev, staging, prod)      | `string`      | `"staging"`|
| `aws_account_id`         | The AWS account ID                             | `string`      | n/a        |
| `common_tags`            | Common tags for all resources                  | `map(string)` | `{}`       |
| `lambda_schedule_expression` | The schedule expression for the Lambda function | `string`      | n/a        |
| `lambda_zip_file`        | Path to the Lambda ZIP file                    | `string`      | n/a        |
| `bucket_name`            | The name of the S3 bucket                      | `string`      | n/a        |
| `invalidation_paths`     | List of paths to invalidate (e.g., ['/index.html', '/*']) | `list(string)` | `[]`      |

## Outputs
| Name                   | Description                                       |
|------------------------|---------------------------------------------------|
| `lambda_function_name` | Name of the Lambda function for CDN invalidation  |
| `lambda_function_arn`  | ARN of the Lambda function for CDN invalidation   |

## Usage
```hcl
module "cdn_invalidation" {
  source                     = "./cdn-invalidation"
  cloudfront_distribution_id = "E12345ABCDEF"
  environment                = "prod"
  aws_account_id             = "123456789012"
  common_tags                = {
    Project = "MyProject"
  }
  lambda_schedule_expression = "rate(1 hour)"
  lambda_zip_file            = "path/to/lambda_function.zip"
  bucket_name                = "my-bucket-name"
  invalidation_paths         = ["/index.html", "/*"]
}
```

## Notes
- The Lambda function requires the `cloudfront:CreateInvalidation` permission, provided via an IAM policy.
- Ensure the `lambda_zip_file` points to the correct path of your Lambda function's code.
- The optional CloudWatch Event Rule can be used to automate CDN invalidations.

## Outputs
After applying this module, the following outputs are provided:
- **Lambda Function Name**: Useful for debugging or referencing the function elsewhere.
- **Lambda Function ARN**: Can be used in other Terraform configurations or manually.
