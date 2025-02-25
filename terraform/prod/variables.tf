# AWSリージョン
variable "aws_region" {
  description = "AWSのリージョン"
  type        = string
  default     = "us-east-1"
}
# AWSのアクセスキーID
variable "aws_access_key" {
  description = "AWSのアクセスキーID"
  type        = string
}
# AWSのシークレットアクセスキー
variable "aws_secret_key" {
  description = "AWSのシークレットアクセスキー"
  type        = string
}

variable "project_name" {
  description = "プロジェクトの名前を設定"
  type        = string
}
variable "execution_role_arn" {
  description = "タスク用のIAMロールのARN"
  type        = string
}

# ALB関連変数（モジュール呼び出しに対応）

variable "alb_name" {
  description = "ALBの名前"
  type        = string
  default     = "example-alb"
}

variable "target_group_name" {
  description = "ターゲットグループの名前"
  type        = string
  default     = "example-target-group"
}

variable "target_port" {
  description = "ターゲットグループのポート番号 (例: 80)"
  type        = number
  default     = 80
}

variable "listener_port" {
  description = "ALBリスナーのポート番号 (例: 80)"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "ALBリスナーのプロトコル (例: HTTP)"
  type        = string
  default     = "HTTP"
}

variable "subnet_ids" {
  description = "ALBを配置するサブネットIDのリスト"
  type        = list(string)
  default     = ["subnet-0123456789abcdef0", "subnet-1123456789abcdef0"]
}

variable "vpc_id" {
  description = "ALBが関連付けられるVPC ID"
  type        = string
  default     = "vpc-0123456789abcdef0"
}

variable "internal_alb" {
  description = "ALBを内部専用に設定するか (true or false)"
  type        = bool
  default     = false
}

variable "health_check_path" {
  description = "ALBターゲットグループのヘルスチェック用パス"
  type        = string
  default     = "/health"
}

variable "tags" {
  description = "ALBに付与するタグ"
  type        = map(string)
  default     = {
    Environment = "production"
  }
}