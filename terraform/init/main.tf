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
resource "aws_subnet" "my_subnet_a" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.public_subnet_az1
  map_public_ip_on_launch = true
  tags = {
    Name = "phpdrill-subnet_a"
  }
}

# サブネットの作成
resource "aws_subnet" "my_subnet_c" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.public_subnet_az2
  map_public_ip_on_launch = true
  tags = {
    Name = "phpdrill-subnet_c"
  }
}

# サブネットにルートテーブルを関連付ける
resource "aws_route_table_association" "my_route_table_association" {
  subnet_id      = aws_subnet.my_subnet_a.id
  route_table_id = aws_route_table.my_route_table.id
}
# サブネットにルートテーブルを関連付ける
resource "aws_route_table_association" "my_route_table_association2" {
  subnet_id      = aws_subnet.my_subnet_c.id
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
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
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
  name = "bluemandrill.xyz" # ドメイン名を指定
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


# ECRリポジトリの作成
resource "aws_ecr_repository" "my_ecr" {
  name = "phpdrill-repo"

  tags = {
    Name = "phpdrill-ecr"
  }
}
resource "aws_ecr_lifecycle_policy" "my_ecr_lifecycle_policy" {
  repository = aws_ecr_repository.my_ecr.name

  policy = file("resources/ecr_lifecycle_policy.json")
}

data "aws_iam_policy_document" "ecr_policy" {
  statement {
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]
    resources = [aws_ecr_repository.my_ecr.arn]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "ecr_access_policy" {
  name        = "ecr-access-policy"
  description = "Allow ECR Pull/Push for specific repository"
  policy      = data.aws_iam_policy_document.ecr_policy.json
}


resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            = aws_vpc.my_vpc.id
  service_name = "com.amazonaws.${var.aws_region}.ecr.api" # ECR APIのサービス名
  vpc_endpoint_type = "Interface"

  security_group_ids = [aws_security_group.my_sg.id]

  private_dns_enabled = true

  subnet_ids = [
    aws_subnet.my_subnet_a.id,
    aws_subnet.my_subnet_c.id
  ]

  tags = {
    Name = "phpdrill-ecr-api-endpoint"
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = aws_vpc.my_vpc.id
  service_name = "com.amazonaws.${var.aws_region}.ecr.dkr" # ECR Dockerのサービス名
  vpc_endpoint_type = "Interface"

  private_dns_enabled = true

  security_group_ids = [aws_security_group.my_sg.id]

  subnet_ids = [
    aws_subnet.my_subnet_a.id,
    aws_subnet.my_subnet_c.id
  ]

  tags = {
    Name = "phpdrill-ecr-dkr-endpoint"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.my_vpc.id
  service_name = "com.amazonaws.${var.aws_region}.s3" # S3のサービス名 (ECRがS3を内部的に使用)
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.my_route_table.id
  ]

  tags = {
    Name = "phpdrill-s3-endpoint"
  }
}

