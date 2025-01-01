output "terraform_state_bucket_name" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "terraform_state_bucket_id" {
  value = aws_s3_bucket.terraform_state.id
}