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

variable "public_subnet_configs" {
  description = <<EOT
パブリックサブネットの CIDR ブロックを指定してください。
EOT
  type = list(object({
    cidr_block = string
    az         = string
  }))
  default = [
    {
      cidr_block = "172.16.0.0/24",
      az         = "ap-northeast-1a"
    },
    {
      cidr_block = "172.16.1.0/24",
      az         = "ap-northeast-1c"
    },
  ]
}

variable "private_subnet_configs" {
  description = <<EOT
プライベートサブネットの CIDR ブロックを指定してください。
EOT
  type = list(object({
    cidr_block = string
    az         = string
  }))
  default = [
    {
      cidr_block = "172.16.2.0/23",
      az         = "ap-northeast-1a"
    },
    {
      cidr_block = "172.16.4.0/23",
      az         = "ap-northeast-1c"
    },
  ]
}
