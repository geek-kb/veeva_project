# IAM Role for CloudFront to Access S3
resource "aws_iam_role" "cloudfront_s3_access" {
  name = "${var.environment}-cloudfront-s3-access-role"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Service : "cloudfront.amazonaws.com"
        },
        Action : "sts:AssumeRole"
      }
    ]
  })

  tags = merge(var.common_tags, {
    Name        = "${var.environment}-cloudfront-s3-access-role"
    Environment = var.environment
  })
}

# IAM Policy for CloudFront to Access S3
resource "aws_iam_policy" "cloudfront_s3_policy" {
  name        = "${var.environment}-cloudfront-s3-policy"
  description = "Policy for CloudFront to access S3 bucket"

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : [
          "s3:GetObject"
        ],
        Resource : [
          "${var.s3_bucket_arn}/*"
        ]
      }
    ]
  })
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "cloudfront_s3_attachment" {
  role       = aws_iam_role.cloudfront_s3_access.name
  policy_arn = aws_iam_policy.cloudfront_s3_policy.arn
}

# IAM Role for CloudFront Invalidation (Optional)
resource "aws_iam_role" "cloudfront_invalidation" {
  name = "${var.environment}-cloudfront-invalidation-role"
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
    Name        = "${var.environment}-cloudfront-invalidation-role"
    Environment = var.environment
  })
}

# IAM Policy for CloudFront Invalidation
resource "aws_iam_policy" "cloudfront_invalidation_policy" {
  name        = "${var.environment}-cloudfront-invalidation-policy"
  description = "Policy for CloudFront invalidations"

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : [
          "cloudfront:CreateInvalidation"
        ],
        Resource : "*"
      }
    ]
  })
}

# Attach Policy to Role for Invalidation
resource "aws_iam_role_policy_attachment" "cloudfront_invalidation_attachment" {
  role       = aws_iam_role.cloudfront_invalidation.name
  policy_arn = aws_iam_policy.cloudfront_invalidation_policy.arn
}
