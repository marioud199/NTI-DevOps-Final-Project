resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "marioud-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_eip" "nat" {
 domain = "vpc"

  tags = {
    Name = "nat"
  }
}


resource "aws_subnet" "public_eu_west" {
  count = length(var.public_sub)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_sub[count.index]
  availability_zone       = var.availability_zone[count.index]
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "public-eu-west-${count.index}"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/${var.eks_name}" = "shared"
  }
}

resource "aws_subnet" "private_eu_west" {
  count = length(var.private_sub)
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_sub[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    "Name"                            = "private-eu-west-${count.index}"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${var.eks_name}" = "shared"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = var.route_cidr[0]
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = var.route_cidr[0]
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private"
  }
}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_eu_west[0].id 

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.igw]
}


resource "aws_route_table_association" "public_association" {
  count          = length(var.public_sub)
  subnet_id      = aws_subnet.public_eu_west[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_association" {
  count          = length(var.private_sub)
  subnet_id      = aws_subnet.private_eu_west[count.index].id
  route_table_id = aws_route_table.private.id
}
resource "aws_security_group" "vpc_sg" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 10250
    to_port     = 10250
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
