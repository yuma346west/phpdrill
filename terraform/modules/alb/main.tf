# ALBの作成
resource "aws_lb" "this" {
  name               = var.alb_name
  internal           = var.internal_alb
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnet_ids
  enable_deletion_protection = var.enable_deletion_protection

  tags = merge(
    var.tags,
    {
      Name = var.alb_name
    }
  )
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
}

# ALBリスナーの作成
resource "aws_lb_listener" "php_listener" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.php_tg.arn
  }
}