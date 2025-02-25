provider "aws" {
  region = var.aws_region
}

# VPCを取得
data "aws_vpc" "phpdrill_vpc" {
  filter {
    name = "tag:Name"
    values = ["phpdrill-vpc"] # VPC名に基づくフィルタリング
  }
}

# phpdrill-security-group を取得
data "aws_security_group" "phpdrill_sg" {
  filter {
    name = "tag:Name"
    values = ["phpdrill-security-group"] # セキュリティグループ名に基づくフィルタリング
  }
}

# phpdrill-subnet を取得
data "aws_subnet" "phpdrill_subnet_a" {
  filter {
    name = "tag:Name"
    values = ["phpdrill-subnet_a"] # サブネット名に基づくフィルタリング
  }
}

# phpdrill-subnet を取得
data "aws_subnet" "phpdrill_subnet_c" {
  filter {
    name = "tag:Name"
    values = ["phpdrill-subnet_c"] # サブネット名に基づくフィルタリング
  }
}

module "alb" {
  source = "../modules/alb" # モジュールが保存されているパス

  alb_name                  = "${var.project_name}-alb"
  target_group_name         = "${var.project_name}-php-tg"
  target_port               = 8080
  listener_port             = 80
  listener_protocol         = "HTTP"
  security_groups           = [data.aws_security_group.phpdrill_sg.id]
  subnet_ids                = [data.aws_subnet.phpdrill_subnet_a.id, data.aws_subnet.phpdrill_subnet_c.id]
  vpc_id                    = data.aws_vpc.phpdrill_vpc.id
  internal_alb              = false
  health_check_path         = "/health"
  tags                      = { Environment = "production" }
}

module "ecs" {
  source = "../modules/ecs"

  app_name = "${var.project_name}-ecs"

  network_mode = "awsvpc"

  container_name = "php"

  container_definitions = file("resources/container_definitions.json")
  execution_role_arn    = var.execution_role_arn

  // Networking and Compatibility
  subnets            = [data.aws_subnet.phpdrill_subnet_a.id, data.aws_subnet.phpdrill_subnet_c.id]
  security_groups    = [data.aws_security_group.phpdrill_sg.id]
  assign_public_ip   = false

  // Resource Allocation
  cpu    = "256"
  memory = "512"

  // Service Configuration
  desired_count       = 1
  launch_type         = "FARGATE"
  target_group_arn    = module.alb.target_group_arn
  container_port      = 8000
}