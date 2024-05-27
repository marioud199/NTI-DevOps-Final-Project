
resource "aws_subnet" "subnet_1" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "eu-west-1b"
  map_public_ip_on_launch = true
}
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [
    aws_subnet.subnet_1.id,
    aws_subnet.subnet_2.id
  ]
}
resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "rds_instance" { 
    allocated_storage    = var.allocated_storage
    storage_type         = var.storage_type
    engine               = var.engine
    engine_version       = var.engine_version
    instance_class       = var.instance_class
    db_name              = var.db_name
    username             = var.username
    password             = var.password
    parameter_group_name = var.parameter_group_name
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
    publicly_accessible = false
    vpc_security_group_ids = [aws_security_group.rds_sg.id]
    identifier = "marioud-db"
    iam_database_authentication_enabled = true
    skip_final_snapshot = true
    backup_retention_period = 1
  
}
resource "aws_secretsmanager_secret" "SM" {
  name = "marioud_SM_new"
}
resource "aws_secretsmanager_secret_version" "SM_version"   {
    secret_id = aws_secretsmanager_secret.SM.id
    secret_string = jsonencode({
         username = var.username,  
        password = var.password 
        })
}