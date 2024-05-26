resource "local_file" "inventory" {
  depends_on = [var.depend_on] #aws_instance.jenkins_instance
  filename = var.filename

  content = <<-EOF
  [webserver]
  ${var.ip} #aws_instance.jenkins_instance.public_ip
  EOF

  
}