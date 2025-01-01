# Create a WAF Web ACL
resource "aws_wafv2_web_acl" "frontend_waf" {
  name        = "${var.environment}-frontend-waf"
  scope       = "CLOUDFRONT" # Use REGIONAL for API Gateway or ALB
  description = "WAF for frontend application"
  default_action {
    allow {}
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 1
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      sampled_requests_enabled   = true
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSet"
    }
  }

  rule {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 2
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      sampled_requests_enabled   = true
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesKnownBadInputsRuleSet"
    }
  }

  rule {
    name     = "AWSManagedRulesSQLiRuleSet"
    priority = 3
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      sampled_requests_enabled   = true
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesSQLiRuleSet"
    }
  }

  tags = merge(var.common_tags, {
    Name        = "${var.environment}-frontend-waf",
    Environment = var.environment
  })

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.environment}-frontend-waf"
    sampled_requests_enabled   = true
  }
}

# Associate WAF with CloudFront Distribution
resource "aws_wafv2_web_acl_association" "frontend_waf_association" {
  resource_arn = var.cloudfront_arn
  web_acl_arn  = aws_wafv2_web_acl.frontend_waf.arn
}

# WAF Logging to S3
resource "aws_s3_bucket" "waf_logs" {
  bucket = "${var.environment}-frontend-waf-logs"

  tags = merge(var.common_tags, {
    Name        = "${var.environment}-waf-logs",
    Environment = "${var.environment}"
  })
}

resource "aws_s3_bucket_policy" "waf_logs_policy" {
  bucket = aws_s3_bucket.waf_logs.id

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Sid : "AWSLogDeliveryWrite",
        Effect : "Allow",
        Principal : {
          Service : "logging.s3.amazonaws.com"
        },
        Action : "s3:PutObject",
        Resource : "${aws_s3_bucket.waf_logs.arn}/*",
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
          Service : "logging.s3.amazonaws.com"
        },
        Action : "s3:GetBucketAcl",
        Resource : "${aws_s3_bucket.waf_logs.arn}"
      }
    ]
  })
}

# WAF Logging Configuration
resource "aws_wafv2_web_acl_logging_configuration" "waf_logging" {
  resource_arn = aws_wafv2_web_acl.frontend_waf.arn

  log_destination_configs = [
    aws_s3_bucket.waf_logs.arn
  ]
}
