output "rds_instance_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.rds_instance.endpoint
}

output "rds_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.rds_instance.arn
}

output "rds_security_group_id" {
  description = "The ID of the RDS security group"
  value       = aws_security_group.rds_sg.id
}

output "rds_db_username" {
  description = "The username of the RDS database"
  value       = aws_db_instance.rds_instance.username
}

output "rds_db_password" {
  description = "The password of the RDS database"
  value       = aws_db_instance.rds_instance.password
  sensitive = true
}
