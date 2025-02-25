# phpdrill-security-group を取得
data "aws_security_group" "internal_sg" {
  filter {
    name = "tag:Name"
    values = ["phpdrill_internal"] # セキュリティグループ名に基づくフィルタリング
  }
}

# ALBの作成
resource "aws_lb" "this" {
  name               = var.alb_name
  internal           = var.internal_alb
  load_balancer_type = "application"
  security_groups    = concat(var.security_groups, [data.aws_security_group.internal_sg.id])
  subnets            = var.subnet_ids
  enable_deletion_protection = var.enable_deletion_protection

  tags = merge(
    var.tags,
    {
      Name = var.alb_name
    }
  )
}


# ALBリスナーの作成
resource "aws_lb_listener" "php_listener" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Service Unavailable"
      status_code  = "503"
    }
  }
  # default_action {
  #   type             = "forward"
  #   target_group_arn = aws_lb_target_group.php_tg.arn
  # }
}
# ALBターゲットグループの作成
resource "aws_lb_target_group" "php_tg" {
  name        = var.target_group_name
  port        = var.target_port
  protocol    = var.target_protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    interval            = var.health_check_interval
    path                = var.health_check_path
    protocol            = var.health_check_protocol
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.health_check_timeout
  }

  tags = merge(
    var.tags,
    {
      Name = var.target_group_name
    }
  )

  depends_on = [aws_lb_listener.php_listener]
}

# リスナールールの作成
resource "aws_lb_listener_rule" "php_rule" {
  listener_arn = aws_lb_listener.php_listener.arn
  priority     = 100  # 優先順位を設定（1-50000の間）

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.php_tg.arn
  }

  condition {
    path_pattern {
      values = ["/*"]  # 全てのパスをターゲットグループに転送
    }
  }
}