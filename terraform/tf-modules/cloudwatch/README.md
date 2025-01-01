
# Terraform Module: CloudWatch Monitoring for CloudFront

This module configures CloudWatch resources for monitoring and managing a CloudFront distribution.

## Features

- **CloudWatch Log Group**: A log group for storing CloudFront logs.
- **CloudWatch Dashboard**: A dashboard to visualize CloudFront metrics such as request rates and error rates.
- **CloudWatch Alarm**: An alarm for monitoring high 5xx error rates.

## Resources

### CloudWatch Log Group
- **Resource**: `aws_cloudwatch_log_group.cloudfront_logs`
- **Purpose**: Stores CloudFront logs for analysis and auditing.
- **Retention**: Logs are retained based on the `cdn_logs_retention_days` variable.
- **Tags**: Automatically tagged with environment-specific metadata.

### CloudWatch Dashboard
- **Resource**: `aws_cloudwatch_dashboard.frontend_dashboard`
- **Purpose**: Provides a visual representation of CloudFront metrics, including request counts, error rates, and total error rates.
- **Customizable Widgets**: Configurable to include additional metrics if needed.

### CloudWatch Alarm
- **Resource**: `aws_cloudwatch_metric_alarm.high_5xx_errors`
- **Purpose**: Triggers an alarm when the 5xx error rate exceeds the defined threshold.
- **Threshold**: Configured through variables and triggers notifications to a specified SNS topic.

## Outputs

- **CloudFront Log Group Name**: Name of the CloudWatch log group.
- **Frontend Dashboard Name**: Name of the CloudWatch dashboard for frontend metrics.
- **High 5xx Error Alarm ARN**: ARN of the high 5xx error alarm.

## Variables

| Name                     | Type       | Default       | Description                                      |
|--------------------------|------------|---------------|--------------------------------------------------|
| `environment`            | `string`   | `staging`     | The environment (e.g., dev, prod).              |
| `common_tags`            | `map(string)` | `{}`        | Common tags for all resources.                  |
| `cloudfront_distribution_id` | `string` | -           | The ID of the CloudFront distribution.          |
| `region`                 | `string`   | -             | AWS region for monitoring resources.            |
| `log_retention_days`     | `number`   | -             | Retention period for CloudWatch logs.           |
| `notification_topic_arn` | `string`   | -             | ARN of the SNS topic for alarms.                |
| `cdn_logs_bucket_name`   | `string`   | -             | Name of the S3 bucket for CDN logs.             |
| `cdn_logs_retention_days`| `number`   | -             | Number of days to retain the logs.              |

## Usage

```hcl
module "cloudwatch_monitoring" {
  source = "./path-to-module"

  environment                 = "production"
  cloudfront_distribution_id  = "E1ABC2DEFGHIJK"
  region                      = "us-east-1"
  log_retention_days          = 90
  notification_topic_arn      = "arn:aws:sns:us-east-1:123456789012:my-topic"
  cdn_logs_bucket_name        = "my-cdn-logs"
  cdn_logs_retention_days     = 90
  common_tags = {
    Project     = "MyProject"
    Environment = "production"
  }
}
```

## License

This module is provided under the MIT License. See [LICENSE](./LICENSE) for more information.
