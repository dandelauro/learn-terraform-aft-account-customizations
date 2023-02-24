data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "sandbox_bucket" {
  bucket = "aft-sandbox-${data.aws_caller_identity.current.account_id}"
}
resource "aws_s3_bucket_acl" "sandbox_bucket_acl" {
  bucket = aws_s3_bucket.sandbox_bucket.id
  acl    = "private"
}
resource "aws_s3_bucket_public_access_block" "sandbox_bucket_access" {
  bucket                  = aws_s3_bucket.sandbox_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_versioning" "sandbox_bucket_versioning" {
  bucket = aws_s3_bucket.sandbox_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "sandbox_bucket_encryption" {
  bucket = aws_s3_bucket.sandbox_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
