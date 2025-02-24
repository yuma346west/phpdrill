variable "alb_name" {
  description = "ロードバランサの名前"
  type        = string
}

variable "target_group_name" {
  description = "ターゲットグループの名前"
  type        = string
}

variable "target_port" {
  description = "ターゲットグループのポート番号"
  type        = number
}

variable "target_protocol" {
  description = "ターゲットグループのプロトコル"
  type        = string
  default     = "HTTP"
}

variable "listener_port" {
  description = "ALBリスナーのポート番号"
  type        = number
}

variable "listener_protocol" {
  description = "ALBリスナーのプロトコル"
  type        = string
  default     = "HTTP"
}

variable "internal_alb" {
  description = "ALBを内部アクセス専用にするか"
  type        = bool
  default     = false
}

variable "security_groups" {
  description = "ALBで使用するセキュリティグループIDのリスト"
  type        = list(string)
}

variable "subnet_ids" {
  description = "ALBをデプロイするサブネットIDのリスト"
  type        = list(string)
}

variable "health_check_interval" {
  description = "ヘルスチェックの間隔 (秒)"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "ヘルスチェックのタイムアウト (秒)"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "ヘルスチェック成功数のしきい値"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "ヘルスチェック失敗数のしきい値"
  type        = number
  default     = 2
}

variable "health_check_path" {
  description = "ターゲットのヘルスチェックに使用するパス"
  type        = string
  default     = "/"
}

variable "health_check_protocol" {
  description = "ヘルスチェックに使用するプロトコル"
  type        = string
  default     = "HTTP"
}

variable "target_type" {
  description = "ターゲットタイプ (instance, ip, or lambda)"
  type        = string
  default     = "instance"
}

variable "vpc_id" {
  description = "ALBが関連付けられているVPCのID"
  type        = string
}

variable "tags" {
  description = "ALBに適用される共有タグ"
  type        = map(string)
  default     = {}
}

variable "enable_deletion_protection" {
  description = "削除保護を有効にするかどうか"
  type        = bool
  default     = false
}