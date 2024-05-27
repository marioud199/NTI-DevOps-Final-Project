variable "eks_name" {
  type = string
}
variable "vpc_cidr" {
  
}
variable "public_sub" {
  
}
variable "private_sub" {
  
}
variable "route_cidr" {
  
}
variable "availability_zone" {
  type = list(string)
}
variable "pri_subnet_ids" {
   type = list(string)

}

variable "pub_subnet_ids" {
    type = list(string)

}
variable "engine_version" {

  
}
variable "storage_type" {
  
}
variable "db_name" {
  
}
variable "username" {
  
}
variable "password" {
  
}
variable "parameter_group_name" {
  
}
variable "allocated_storage" {
  
}   
variable "instance_class" {
  
}   
variable "engine" {
  
}


variable "desired" {
  
}
variable "max_size" {
  
}
variable "min_size" {
  
}
variable "aws_account_id" {
  
}
variable "bucket_name" {
  
}
variable "filename" {
  
}

variable "region" {
  
}
