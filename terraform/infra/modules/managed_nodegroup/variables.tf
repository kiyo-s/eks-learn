// General
variable "resource_name_prefix" {
  description = "リソース名に付与するプレフィックスを指定してください。"
  type        = string
}

variable "tags" {
  description = "リソースに付与するタグを指定してください。"
  type        = map(string)
}

// IAM
variable "ami_id" {
  description = "EKS ノードで使用する AMI ID を指定してください。"
  type        = string
}

variable "instance_type" {
  description = "EKS ノードで使用するインスタンスタイプを指定してください。"
  type        = string
}

// Network
variable "vpc_id" {
  description = "EKS ノードを配置する VPC の ID を指定してください。"
  type        = string
}
