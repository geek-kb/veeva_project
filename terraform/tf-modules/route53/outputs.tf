output "route53_record_name" {
  description = "The name of the Route 53 record"
  value       = aws_route53_record.frontend.name
}

output "route53_record_fqdn" {
  description = "The fully qualified domain name of the Route 53 record"
  value       = aws_route53_record.frontend.fqdn
}

output "cloudfront_hosted_zone_id" {
  description = "The ID of the Route 53 hosted zone"
  value       = var.cloudfront_hosted_zone_id
}