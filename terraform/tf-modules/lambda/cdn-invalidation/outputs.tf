output "lambda_function_name" {
  description = "Name of the Lambda function for CDN invalidation"
  value       = aws_lambda_function.cdn_invalidation_lambda.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function for CDN invalidation"
  value       = aws_lambda_function.cdn_invalidation_lambda.arn
}

