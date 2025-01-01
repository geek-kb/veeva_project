output "ssm_parameter_arns" {
  description = "ARNs of the created SSM parameters"
  value       = [for param in aws_ssm_parameter.parameters : param.arn]
}

output "ssm_parameter_names" {
  description = "Names of the created SSM parameters"
  value       = keys(aws_ssm_parameter.parameters)
}

output "session_manager_document_name" {
  description = "The name of the Session Manager document"
  value       = aws_ssm_document.session_manager.name
}

output "patch_baseline_arn" {
  description = "The ARN of the Patch Baseline"
  value       = var.enable_patch_baseline ? aws_ssm_patch_baseline.patch_baseline[0].arn : null
}
