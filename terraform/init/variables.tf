# AWSリージョン
variable "aws_region" {
  description = "AWSのリージョン"
  type        = string
  default     = "us-east-1"
}

# AMI ID
variable "ami_id" {
  description = "EC2インスタンスで使用するAMIのID"
  type        = string
  default     = "ami-0c02fb55956c7d316" # Amazon Linux 2 の AMI ID（us-east-1)
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

variable "public_subnet_az1" {
  description = "Public Subnet AZ1"
  type        = string
}
variable "public_subnet_az2" {
  description = "Public Subnet AZ2"
  type        = string
}