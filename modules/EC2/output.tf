output "ec2_arn" {
  value = aws_instance.jenkins_instance.arn
}
output "public_ip" {
  value = aws_instance.jenkins_instance.public_ip
}