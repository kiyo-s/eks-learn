// KMS to encrypt the bucket
resource "aws_kms_key" "tfstate_bucket" {
  description             = "KMS key to encrypt the bucket"
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "tfstate_bucket" {
  name          = "alias/${local.name}"
  target_key_id = aws_kms_key.tfstate_bucket.key_id
}
