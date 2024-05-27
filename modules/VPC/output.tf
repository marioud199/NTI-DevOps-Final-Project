output "pri_subnet_ids" {
  value = aws_subnet.private_eu_west[*].id
}

output "pub_subnet_ids" {
  value = aws_subnet.public_eu_west[*].id
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
output "vpc_sg" {
  value = aws_security_group.vpc_sg.id
}