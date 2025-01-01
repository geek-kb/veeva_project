# CloudWatch Log Group for CloudFront Logs
resource "aws_cloudwatch_log_group" "cloudfront_logs" {
  name              = "/aws/cloudfront/${var.environment}-frontend"
  retention_in_days = var.cdn_logs_retention_days

  tags = merge(var.common_tags, {
    Name        = "cloudfront-logs-${var.environment}"
    Environment = var.environment
  })
}

# CloudWatch Dashboard for Frontend Metrics
resource "aws_cloudwatch_dashboard" "frontend_dashboard" {
  dashboard_name = "${var.environment}-frontend-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric",
        x      = 0,
        y      = 0,
        width  = 12,
        height = 6,
        properties = {
          metrics = [
            ["AWS/CloudFront", "Requests", "DistributionId", var.cloudfront_distribution_id],
            ["AWS/CloudFront", "4xxErrorRate", "DistributionId", var.cloudfront_distribution_id],
            ["AWS/CloudFront", "5xxErrorRate", "DistributionId", var.cloudfront_distribution_id],
            ["AWS/CloudFront", "TotalErrorRate", "DistributionId", var.cloudfront_distribution_id],
          ]
          title   = "CloudFront Metrics"
          view    = "timeSeries"
          stacked = false
          region  = var.region
        }
      }
    ]
  })
}

# CloudWatch Alarm for High 5xx Errors
resource "aws_cloudwatch_metric_alarm" "high_5xx_errors" {
  alarm_name          = "${var.environment}-high-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "5xxErrorRate"
  namespace           = "AWS/CloudFront"
  period              = 60
  statistic           = "Average"
  threshold           = 5

  dimensions = {
    DistributionId = var.cloudfront_distribution_id
  }

  alarm_actions = [var.notification_topic_arn]

  tags = merge(var.common_tags, {
    Name        = "high-5xx-errors-alarm-${var.environment}"
    Environment = var.environment
  })
}
