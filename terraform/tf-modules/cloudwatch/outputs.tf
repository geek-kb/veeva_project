output "cloudfront_log_group_name" {
  description = "The name of the CloudFront log group"
  value       = aws_cloudwatch_log_group.cloudfront_logs.name
}

output "frontend_dashboard_name" {
  description = "The name of the CloudWatch dashboard for the frontend"
  value       = aws_cloudwatch_dashboard.frontend_dashboard.dashboard_name
}

output "high_5xx_error_alarm_arn" {
  description = "The ARN of the high 5xx error alarm"
  value       = aws_cloudwatch_metric_alarm.high_5xx_errors.arn
}
