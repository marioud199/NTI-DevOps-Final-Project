provider "aws" {
    region = "eu-west-1"
}

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}
module "vpc" {
    source = "./VPC"
    vpc_cidr = var.vpc_cidr
    public_sub = var.public_sub
    private_sub = var.private_sub
    route_cidr = var.route_cidr
    availability_zone = var.availability_zone
    pri_subnet_ids = var.pri_subnet_ids
    pub_subnet_ids = var.pub_subnet_ids
    eks_name = "marioud_cluster"
}
   
  

module "eks" {
    source = "./EKS"
    eks_name = "marioud_cluster"
    pri_subnet_ids = module.vpc.pri_subnet_ids
    pub_subnet_ids = module.vpc.pub_subnet_ids
    desired = var.desired
    max_size = var.max_size
    min_size = var.min_size
    depends_on = [ module.vpc ]
    
}
# module "RDS" {  
#     source = "./RDS"
#     engine = var.engine
#     engine_version = var.engine_version
#     instance_class = var.instance_class
#     db_name = var.db_name
#     username = var.username
#     password = var.password
#     parameter_group_name = var.parameter_group_name
#     allocated_storage = var.allocated_storage
#     storage_type = var.storage_type
#     db_subnet_group = module.vpc.pub_subnet_ids
#     vpc_id = module.vpc.vpc_id
    

  
# }
 module "ec2"{
     source = "./EC2"
     jenk_sub = module.vpc.pub_subnet_ids[0]
     jenk_sg = module.vpc.vpc_sg
   
 }
 module "backup" {
     source = "./backup"
     ec2_arn  = module.ec2.ec2_arn
  
 }
 module "aws_s3_bucket" {
     source = "./s3bucket"
     bucket_name = var.bucket_name
     aws_account_id = var.aws_account_id

  
 }
 module "local_file"{
     source = "./local_file"
     filename = var.filename
     depend_on = [module.ec2.ec2_arn]
     ip = module.ec2.public_ip

 }
module "ecr" {
  source = "./ECR"
  ecr_name = "backend_repo"
  image_tag_mutability = "MUTABLE"

  
}
module "ecr2" {
  source = "./ECR"
  ecr_name = "frontend_repo"
  image_tag_mutability = "MUTABLE"
  
  
}
