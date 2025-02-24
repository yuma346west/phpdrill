output "alb_arn" {
  description = "ALBのARN"
  value       = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "ALBのDNS名"
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "ターゲットグループのARN"
  value       = aws_lb_target_group.php_tg.arn
}

output "listener_arn" {
  description = "リスナーのARN"
  value       = aws_lb_listener.php_listener.arn
}