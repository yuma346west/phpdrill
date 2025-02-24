variable "app_name" {
  description = "アプリケーションの名前 (クラスター、タスク、サービス名に使用)"
  type        = string
}

variable "container_definitions" {
  description = "ECSタスクに関連付けられたコンテナ定義のJSON"
  type        = string
}

variable "execution_role_arn" {
  description = "タスクの実行に使用するIAMロールARN"
  type        = string
}

variable "network_mode" {
  description = "ECSタスクのネットワークモード (例: bridge, host, awsvpc)"
  type        = string
}

variable "cpu" {
  description = "ECSタスクで使用するCPUユニット数"
  type        = string
}

variable "memory" {
  description = "ECSタスクで使用するメモリ量"
  type        = string
}

variable "desired_count" {
  description = "ECSサービスのデプロイ時に実行するタスクの数"
  type        = number
}

variable "launch_type" {
  description = "ECSサービスの起動タイプ (例: FARGATE, EC2)"
  type        = string
}

variable "subnets" {
  description = "ECSサービスをデプロイするサブネットのリスト"
  type = list(string)
}

variable "security_groups" {
  description = "ECSサービスに割り当てられるセキュリティグループのリスト"
  type = list(string)
}

variable "assign_public_ip" {
  description = "ECSサービスにパブリックIPを割り当てるかどうか (true/false)"
  type        = bool
}

variable "target_group_arn" {
  description = "ALBのターゲットグループARN"
  type        = string
}

variable "container_name" {
  description = "ロードバランサに関連付けられるコンテナ名"
  type        = string
}

variable "container_port" {
  description = "ロードバランサに関連付けられるコンテナポート"
  type        = number
}