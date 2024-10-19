resource "aws_kms_key" "sops" {
  description             = "KMS key for SOPS"
  enable_key_rotation     = true
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "sops" {
  name          = "alias/${local.name}-sops"
  target_key_id = aws_kms_key.sops.key_id
}
