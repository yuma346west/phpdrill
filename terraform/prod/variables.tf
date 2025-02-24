variable "project_name" {
  description = "プロジェクトの名前を設定"
  type        = string
}
variable "execution_role_arn" {
  description = "タスク用のIAMロールのARN"
  type        = string
}

variable "subnets" {
  description = "対象のサブネットリスト"
  type        = list(string)
}

variable "security_groups" {
  description = "ECSサービスのセキュリティグループ"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ロードバランサーのターゲットグループARN"
  type        = string
}

