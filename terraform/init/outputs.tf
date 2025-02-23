# 作成したリソースのIDを出力
output "vpc_id" {
  description = "作成されたVPCのID"
  value       = aws_vpc.my_vpc.id
}

output "subnet_id" {
  description = "作成されたサブネットのID"
  value       = aws_subnet.my_subnet.id
}

output "ec2_public_ip" {
  description = "EC2インスタンスのパブリックIP"
  value       = aws_instance.my_instance.public_ip
}