# Create an SNS Topic
resource "aws_sns_topic" "frontend_notifications" {
  name = "${var.environment}-frontend-notifications"

  tags = merge(var.common_tags, {
    Name        = "${var.environment}-frontend-notifications",
    Environment = var.environment
  })
}

# Attach an SNS Policy for Publishing (Optional)
resource "aws_sns_topic_policy" "sns_policy" {
  arn = aws_sns_topic.frontend_notifications.arn

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : "*",
        Action : "sns:Publish",
        Resource : aws_sns_topic.frontend_notifications.arn,
        Condition : {
          StringEquals : {
            "aws:SourceAccount" : var.aws_account_id
          }
        }
      }
    ]
  })
}

# SNS Subscription Example (Optional)
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.frontend_notifications.arn
  protocol  = "email"
  endpoint  = var.notification_email
}
