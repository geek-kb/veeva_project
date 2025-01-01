# Terraform Module: SNS Configuration

This module provides resources to configure an Amazon Simple Notification Service (SNS) topic and manage its subscriptions and policies.

## Resources

### SNS Topic
- **Resource**: `aws_sns_topic.frontend_notifications`
  - Creates an SNS topic for frontend notifications.

### SNS Topic Policy
- **Resource**: `aws_sns_topic_policy.sns_policy`
  - Configures a policy to allow publishing messages to the SNS topic.

### SNS Subscription (Optional)
- **Resource**: `aws_sns_topic_subscription.email_subscription`
  - Example subscription for email notifications.

## Inputs

| Name                  | Description                                   | Type        | Default  | Required |
|-----------------------|-----------------------------------------------|-------------|----------|----------|
| `environment`         | The environment for the SNS topic            | `string`    | -        | Yes      |
| `aws_account_id`      | AWS account ID                               | `string`    | -        | Yes      |
| `notification_email`  | Email address to subscribe to the SNS topic  | `string`    | -        | Yes      |
| `common_tags`         | Common tags to apply to all resources        | `map(string)` | `{}`   | No       |

## Outputs

| Name                | Description                        |
|---------------------|------------------------------------|
| `sns_topic_arn`     | ARN of the SNS topic               |
| `sns_topic_name`    | Name of the SNS topic              |

## Example Usage

```hcl
module "sns" {
  source = "./sns"

  environment        = "staging"
  aws_account_id     = "123456789012"
  notification_email = "example@example.com"

  common_tags = {
    Project = "Example"
    Owner   = "DevOps Team"
  }
}
