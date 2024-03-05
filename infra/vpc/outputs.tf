output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet1_id" {
  value = aws_subnet.subnet1.id
}

output "subnet2_id" {
  value = aws_subnet.subnet2.id
}

output "sg_allow_http_id" {
  value       = aws_security_group.allow_http.id
  description = "Security Group to allow HTTP traffic"
}

output "sg_default_id" {
  value = aws_default_security_group.default.id
}

