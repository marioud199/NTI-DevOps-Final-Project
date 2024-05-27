variable "vpc_cidr" {
  type = string
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
variable "eks_name" {
    
}
