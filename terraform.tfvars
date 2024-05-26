eks_name= "marioud_cluster" 
vpc_cidr= "10.0.0.0/16"

public_sub=["10.0.1.0/24","10.0.2.0/24"]

private_sub=["10.0.3.0/24","10.0.4.0/24"]

route_cidr=["0.0.0.0/0"]



availability_zone = ["eu-west-1a","eu-west-1b"]

pri_subnet_ids = ["private-eu-west-1a", "private-eu-west-1b"]

pub_subnet_ids = [" public-eu-west-1a","public-eu-west-1b"]
storage_type         = "gp2"
engine               = "mysql"
engine_version       = "5.7.44"
instance_class       = "db.t3.micro"
db_name              =  "marioud_db"
username             = "marioud"
password             = "marioud_password"
parameter_group_name = "default.mysql5.7"
allocated_storage    = 20 
aws_account_id =     "730335618715"
desired = 1
max_size     = 3
min_size     = 1
bucket_name = "marioud-bucket"
filename = "./inventory.INI"