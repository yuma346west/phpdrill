data "aws_security_group" "internal_sg" {
  filter {
    name = "tag:Name"
    values = ["phpdrill_internal"] # セキュリティグループ名に基づくフィルタリング
  }
}
resource "aws_ecs_cluster" "cluster" {
  name = "${var.app_name}-cluster"
}

resource "aws_ecs_task_definition" "task" {
  family                   = "${var.app_name}-task"
  container_definitions    = var.container_definitions
  execution_role_arn       = var.execution_role_arn
  network_mode             = var.network_mode
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
}

resource "aws_ecs_service" "service" {
  name            = "${var.app_name}-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type
  network_configuration {
    subnets          = var.subnets
    security_groups  = concat(var.security_groups, [data.aws_security_group.internal_sg.id])
    assign_public_ip = var.assign_public_ip
  }
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}

# CloudWatch Logs グループの作成
resource "aws_cloudwatch_log_group" "php_phpdrill" {
  name              = "/ecs/phpdrill"  # ロググループ名
  retention_in_days = 30              # ログの保持期間（日数）

  tags = {
    Environment = "production"
    Application = "phpdrill"
  }
}


