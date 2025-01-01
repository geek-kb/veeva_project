# IAM Policy for S3 Bucket and DynamoDB Table Access
resource "aws_iam_policy" "terraform_state" {
  name        = "TerraformStateAccessPolicy"
  description = "Policy to allow Terraform to manage remote state in S3 and DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "AllowS3BucketAccess",
        Effect   = "Allow",
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.terraform_state.bucket}",
          "arn:aws:s3:::${aws_s3_bucket.terraform_state.bucket}/*"
        ]
      },
      {
        Sid      = "AllowDynamoDBAccess",
        Effect   = "Allow",
        Action   = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query"
        ],
        Resource = "arn:aws:dynamodb:${local.aws_region}:${local.aws_account_id}:table/terraform-state-locks"
      }
    ]
  })
}

# IAM Role for Terraform State Management
resource "aws_iam_role" "terraform_state_role" {
  name               = "TerraformStateRole"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          "AWS": "arn:aws:iam::${local.aws_account_id}:user/itaig"
        },
        Action : "sts:AssumeRole"
      }
    ]
  })
}

# Attach the Policy to the Role
resource "aws_iam_role_policy_attachment" "terraform_state_attachment" {
  role       = aws_iam_role.terraform_state_role.name
  policy_arn = aws_iam_policy.terraform_state.arn
}

# Output the Role ARN for reference
# output "terraform_state_role_arn" {
#   description = "The ARN of the IAM role for Terraform state management"
#   value       = aws_iam_role.terraform_state_role.arn
# }
