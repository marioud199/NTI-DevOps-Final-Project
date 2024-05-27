resource "aws_instance" "jenkins_instance" {
  ami           = "ami-0776c814353b4814d" 
  instance_type = "t2.medium"
  subnet_id     = var.jenk_sub
  key_name      = "mar-jenkins" 

  associate_public_ip_address = true

  security_groups = [var.jenk_sg]

  tags = {
    Name = "jenkins-instance"
  }
}

