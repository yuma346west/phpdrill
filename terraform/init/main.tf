# プロバイダーの設定
provider "aws" {
  region = var.aws_region
}

# VPCの作成
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "phpdrill-vpc"
  }
}

# インターネットゲートウェイの作成
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "phpdrill-internet-gateway"
  }
}

# ルートテーブルの作成
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  # すべてのトラフィックをインターネットゲートウェイに送るルート
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "phpdrill-route-table"
  }
}

# サブネットの作成
resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.public_subnet_az1
  map_public_ip_on_launch = true
  tags = {
    Name = "phpdrill-subnet"
  }
}

# サブネットにルートテーブルを関連付ける
resource "aws_route_table_association" "my_route_table_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

# セキュリティグループの作成
resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "phpdrill-security-group"
  }
}

# Route53 Hosted Zoneの作成
resource "aws_route53_zone" "bluemandrill" {
  name = "bluemandrill.com" # ドメイン名を指定
  tags = {
    Name = "bluemandrill-hosted-zone"
  }
}

# Route53 レコードの作成 (Aレコード)
resource "aws_route53_record" "bluemandrill_record" {
  zone_id = aws_route53_zone.bluemandrill.zone_id # Hosted Zone IDを指定
  name    = "www"
  type    = "A"
  ttl     = 300 # DNSキャッシュの有効期間

  records = [
    "192.0.2.1", # 指定するIPアドレス
  ]
}