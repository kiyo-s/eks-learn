// KMS to encrypt the bucket
resource "aws_kms_key" "tfstate_bucket" {
  description             = "KMS key to encrypt the bucket"
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "tfstate_bucket" {
  name          = "alias/${local.name}"
  target_key_id = aws_kms_key.tfstate_bucket.key_id
}

// S3 Bucket for Terraform State
resource "aws_s3_bucket" "tfstate" {
  bucket = local.name
}

resource "aws_s3_bucket_versioning" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    bucket_key_enabled = true
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_alias.tfstate_bucket.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
