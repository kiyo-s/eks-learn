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

// EKS
variable "eks_cluster_access_cidrs" {
  description = <<EOT
EKS クラスタの API Server にアクセス可能な CIDR ブロックを配列で指定してください。
EOT
  type        = list(string)
}

variable "ami_id" {
  description = "EKS ノードで使用する AMI ID を指定してください。"
  type        = string
  default     = "ami-082334f38f661d103"
}

variable "node_resources_system" {
  description = "EKS ノード (system) のリソースを指定してください。"
  type = object({
    instance_type = string
    min_size      = number
    max_size      = number
    desired_size  = number
  })
  default = {
    instance_type = "m7i-flex.large"
    min_size      = 0
    max_size      = 5
    desired_size  = 1
  }
}

variable "node_resources_business" {
  description = "EKS ノード (business) のリソースを指定してください。"
  type = object({
    instance_type = string
    min_size      = number
    max_size      = number
    desired_size  = number
  })
  default = {
    instance_type = "m7i-flex.large"
    min_size      = 0
    max_size      = 5
    desired_size  = 0
  }
}

variable "max_unavailable_percentage" {
  description = "EKS ノードのアップデート時に許容する最大のアンアベイラビリティを指定してください。"
  type        = number
  default     = 10
}
