variable "env" {
  description = "環境を識別する文字列を指定してください。"
  type        = string
}

variable "region" {
  description = "リソースを作成する AWS のリージョンを指定してください。"
  type        = string
  default     = "ap-northeast-1"
}
