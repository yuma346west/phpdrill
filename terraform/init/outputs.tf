# 作成したリソースのIDを出力
output "vpc_id" {
  description = "作成されたVPCのID"
  value       = aws_vpc.my_vpc.id
}

output "subnet_id" {
  description = "作成されたサブネットのID"
  value       = aws_subnet.my_subnet_a.id
}

