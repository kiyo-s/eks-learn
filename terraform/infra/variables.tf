variable "env" {
  description = "環境を識別する文字列を指定してください。"
  type        = string
}

variable "region" {
  description = "リソースを作成する AWS のリージョンを指定してください。"
  type        = string
  default     = "ap-northeast-1"
}

// Network
variable "vpc_cidr_block" {
  description = "VPC の CIDR ブロックを指定してください。"
  type        = string
  default     = "172.16.0.0/16"
}
