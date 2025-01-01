# Create SSM Parameters
resource "aws_ssm_parameter" "parameters" {
  for_each = var.ssm_parameters

  name        = each.key
  type        = each.value.type
  value       = each.value.value
  description = each.value.description
  tier        = each.value.tier

  tags = merge(var.tags, {
    Name        = each.key,
    Environment = var.environment
  })
}

# Enable Session Manager Logging
resource "aws_ssm_document" "session_manager" {
  name            = "${var.environment}-SessionManagerLogging"
  document_type   = "Command"
  document_format = "JSON"
  content = jsonencode({
    schemaVersion = "2.2",
    description   = "Enable Session Manager logging to CloudWatch Logs and S3",
    mainSteps = [
      {
        action = "aws:runShellScript",
        name   = "EnableSessionManager",
        inputs = {
          runCommand = [
            "sudo yum install -y amazon-ssm-agent",
            "sudo systemctl enable amazon-ssm-agent",
            "sudo systemctl start amazon-ssm-agent"
          ]
        }
      }
    ]
  })

  tags = merge(var.tags, {
    Name        = "${var.environment}-SessionManagerLogging",
    Environment = var.environment
  })
}

# Patch Baseline (Optional)
resource "aws_ssm_patch_baseline" "patch_baseline" {
  count = var.enable_patch_baseline ? 1 : 0

  name            = "${var.environment}-PatchBaseline"
  operating_system = var.patch_baseline_operating_system
  description     = "Patch baseline for ${var.environment}"

  approval_rule {
    approve_after_days = var.patch_approval_days

    compliance_level = "CRITICAL"
    enable_non_security = false

    patch_filter {
      key    = "PRODUCT"
      values = var.patch_baseline_product
    }
  }

  tags = merge(var.tags, {
    Name        = "${var.environment}-PatchBaseline",
    Environment = var.environment
  })
}
