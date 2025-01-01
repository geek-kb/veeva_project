# IAM Role for Lambda Function (Optional if using a Lambda trigger)
resource "aws_iam_role" "lambda_cdn_invalidation_role" {
  name = "${var.environment}-cdn-invalidation-role"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Service : "lambda.amazonaws.com"
        },
        Action : "sts:AssumeRole"
      }
    ]
  })

  tags = merge(var.common_tags, {
    Name        = "${var.environment}-cdn-invalidation-role",
    Environment = var.environment
  })
}

# IAM Policy for Lambda - CloudFront Invalidation
resource "aws_iam_policy" "lambda_cdn_invalidation_policy" {
  name        = "${var.environment}-cdn-invalidation-lambda-policy"
  description = "Policy for Lambda to perform CloudFront invalidations"

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : "cloudfront:CreateInvalidation",
        Resource : "arn:aws:cloudfront::${var.aws_account_id}:distribution/${var.cloudfront_distribution_id}"
      }
    ]
  })
}

# Attach IAM Policy to Lambda Role
resource "aws_iam_role_policy_attachment" "lambda_cdn_invalidation_attachment" {
  role       = aws_iam_role.lambda_cdn_invalidation_role.name
  policy_arn = aws_iam_policy.lambda_cdn_invalidation_policy.arn
}

# Lambda Function for CDN Invalidation
resource "aws_lambda_function" "cdn_invalidation_lambda" {
  filename      = "cdn_invalidation_lambda.zip"
  function_name = "${var.environment}-cdn-invalidation"
  role          = aws_iam_role.lambda_cdn_invalidation_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  timeout       = 60
  memory_size   = 128
  environment {
    variables = {
      CLOUDFRONT_DISTRIBUTION_ID = var.cloudfront_distribution_id
      INVALIDATION_PATHS         = join(",", var.invalidation_paths)
      BUCKET_NAME                = var.bucket_name
    }
  }

  tags = merge(var.common_tags, {
    Name        = "${var.environment}-cdn-invalidation",
    Environment = var.environment
  })
}

# (Optional) Trigger Lambda with CloudWatch Events
resource "aws_cloudwatch_event_rule" "cdn_invalidation_rule" {
  name                = "${var.environment}-cdn-invalidation-rule"
  description         = "Trigger Lambda for CDN invalidation"
  schedule_expression = var.lambda_schedule_expression
}

resource "aws_cloudwatch_event_target" "cdn_invalidation_target" {
  rule      = aws_cloudwatch_event_rule.cdn_invalidation_rule.name
  target_id = aws_lambda_function.cdn_invalidation_lambda.function_name
  arn       = aws_lambda_function.cdn_invalidation_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_invoke_lambda" {
  statement_id  = "AllowCloudWatchToInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cdn_invalidation_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cdn_invalidation_rule.arn
}
