resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = "terraform-remote-state-bucket-${random_string.suffix.id}"
  force_destroy = true

  tags = {
    Name        = "Terraform Remote State"
    Environment = "Shared"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_acl" "terraform_state" {
  depends_on = [ aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership ]
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = "Shared"
  }
}

data "aws_s3_bucket" "name" {
  bucket = aws_s3_bucket.terraform_state.bucket
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.terraform_state.id
  key    = "${local.environment}/"
}