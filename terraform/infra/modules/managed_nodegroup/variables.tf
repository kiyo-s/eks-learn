// General
variable "resource_name_prefix" {
  description = "リソース名に付与するプレフィックスを指定してください。"
  type        = string
}

variable "tags" {
  description = "リソースに付与するタグを指定してください。"
  type        = map(string)
}

// Network
variable "vpc_id" {
  description = "EKS ノードを配置する VPC の ID を指定してください。"
  type        = string
}

variable "subnet_ids" {
  description = "EKS ノードを配置するサブネットの ID を指定してください。"
  type        = list(string)
}

// EKS
variable "eks_cluster_name" {
  description = "EKS クラスタの名前を指定してください。"
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS クラスタのエンドポイントを指定してください。"
  type        = string
}

variable "cluster_ca" {
  description = "EKS クラスタの CA データを指定してください。"
  type        = string
}

variable "cluster_cidr" {
  description = "EKS クラスタの CIDR を指定してください。"
  type        = string
}

variable "eks_cluster_security_group_id" {
  description = "EKS クラスタのセキュリティグループ ID を指定してください。"
  type        = string
}

variable "ami_id" {
  description = "EKS ノードで使用する AMI ID を指定してください。"
  type        = string
}

variable "node_resources" {
  description = "EKS ノードのリソースを指定してください。"
  type = object({
    instance_type = string
    min_size      = number
    max_size      = number
    desired_size  = number
  })
}

variable "k8s_node_labels" {
  description = "EKS ノードに付与する Kubernetes ノードラベルを指定してください。"
  type        = map(string)
  default     = null
}

variable "max_unavailable_percentage" {
  description = "EKS ノードのアップデート時に許容する最大のアンアベイラビリティを指定してください。"
  type        = number
  default     = 10
}

variable "is_enabled_cluster_autoscaler" {
  description = "EKS クラスタのオートスケーラーを有効にするかどうかを指定してください。"
  type        = bool
  default     = false
}

variable "operational_timeout" {
  description = "リソースの作成・更新・削除にかかるタイムアウト時間を指定してください。"
  type        = string
  default     = "60m"
}
