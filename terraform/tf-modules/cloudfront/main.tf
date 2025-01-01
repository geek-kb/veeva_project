# CloudFront Distribution for the Frontend

data "aws_region" "current" {}

resource "aws_cloudfront_origin_access_control" "frontend" {
  name                  = "${var.environment}-frontend-oac"
  description           = "OAC for CloudFront to access S3"
  signing_behavior      = "always"
  signing_protocol      = "sigv4"
  origin_access_control_origin_type = "s3"
}

resource "aws_cloudfront_distribution" "frontend" {
  depends_on = [ aws_cloudfront_origin_access_control.frontend ]
  origin {
    domain_name = var.cloudfront_distribution_bucket_id
    origin_id   = var.cloudfront_distribution_website_endpoint
    origin_access_control_id = aws_cloudfront_origin_access_control.frontend.id
  }

  enabled = true

  default_cache_behavior {
    target_origin_id       = var.cloudfront_distribution_website_endpoint
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  logging_config {
    bucket = "${var.cloudfront_distribution_bucket_id}.s3.amazonaws.com"
    prefix = "cloudfront-logs/"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = merge(var.common_tags, {
    Name        = "cloudfront-distribution-${var.cloudfront_distribution_bucket_name}"
    Environment = var.environment
  })
}

# Cloudfront S3 Bucket - frontend

# data "aws_s3_bucket" "frontend" {
#   bucket = var.cloudfront_distribution_bucket_name
# }

# resource "aws_s3_bucket" "frontend" {
#   count  = data.aws_s3_bucket.frontend.bucket != "" ? 0 : 1
#   bucket        = var.cloudfront_distribution_bucket_name
#   force_destroy = var.cloudfront_distribution_s3_force_destroy
#   tags = merge(var.common_tags, {
#     Name        = var.cloudfront_distribution_bucket_name
#     Environment = var.environment
#   })
# }

# resource "aws_s3_bucket_acl" "frontend" {
#   bucket = aws_s3_bucket.frontend.bucket
#   acl    = var.cloudfront_distribution_s3_bucket_acl
# }

# resource "aws_s3_bucket_website_configuration" "frontend" {
#   bucket = aws_s3_bucket.frontend.id

#   index_document {
#     suffix = "index.html"
#   }

#   error_document {
#     key = "error.html"
#   }

#   routing_rules = var.frontend_bucket_routing_rules
# }

# resource "aws_s3_bucket_policy" "frontend" {
#   bucket = aws_s3_bucket.frontend.id

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect    = "Allow",
#         Principal = "*",
#         Action    = "s3:GetObject",
#         Resource  = "${aws_s3_bucket.frontend.arn}/*"
#       }
#     ]
#   })
# }

# Cloudfront Logs
# S3 Bucket for CloudFront Logs

resource "aws_s3_bucket" "cdn_logs" {
  bucket        = "${var.environment}-${var.cdn_logs_bucket_name}-${random_string.suffix.id}"
  force_destroy = var.cdn_logs_bucket_force_destroy

  tags = merge(var.common_tags, {
    Name        = "${var.environment}-${var.cdn_logs_bucket_name}-${random_string.suffix.id}",
    Environment = var.environment
  })
}

# Bucket Policy for CloudFront Logs
resource "aws_s3_bucket_policy" "cdn_logs_policy" {
  bucket = aws_s3_bucket.cdn_logs.id

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Sid : "AWSLogDeliveryWrite",
        Effect : "Allow",
        Principal : {
          Service : "cloudfront.amazonaws.com"
        },
        Action : "s3:PutObject",
        Resource : "${aws_s3_bucket.cdn_logs.arn}/*",
        Condition : {
          StringEquals : {
            "s3:x-amz-acl" : "bucket-owner-full-control"
          }
        }
      },
      {
        Sid : "AWSLogDeliveryAclCheck",
        Effect : "Allow",
        Principal : {
          Service : "cloudfront.amazonaws.com"
        },
        Action : "s3:GetBucketAcl",
        Resource : aws_s3_bucket.cdn_logs.arn
      }
    ]
  })
}

# Lifecycle Policy for Logs bucket
resource "aws_s3_bucket_lifecycle_configuration" "cdn_logs_lifecycle" {
  bucket = aws_s3_bucket.cdn_logs.id

  rule {
    id     = "LogRetention"
    status = "Enabled"

    expiration {
      days = var.cdn_logs_retention_days
    }
  }
}



####

resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket                  = var.cloudfront_distribution_bucket_id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_cloudfront_origin_access_identity" "frontend" {
  comment = "Access Identity for S3 Bucket"
}

resource "aws_s3_bucket_policy" "frontend" {
  bucket = var.cloudfront_distribution_bucket_id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowCloudFrontAccess",
        Effect    = "Allow",
        Principal = {
          CanonicalUser = aws_cloudfront_origin_access_identity.frontend.cloudfront_access_identity_path
        },
        Action    = "s3:GetObject",
        Resource  = "${var.cloudfront_distribution_bucket_arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "frontend" {
  bucket = var.cloudfront_distribution_bucket_id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rules = var.frontend_bucket_routing_rules
}