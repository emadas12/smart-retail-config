# 1- Define the VPC
resource "aws_vpc" "smart_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = var.vpc_name
    Environment = "project_environment"
    Terraform   = "true"
  }
}

# 2- Deploy public subnets
resource "aws_subnet" "smart_public_subnets" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.smart_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.subnet_new_bits, each.value) # Using a variable for new bits
  map_public_ip_on_launch = true
  availability_zone       = each.key
  tags = {
    Name      = "${each.key}_public_subnet"
    Terraform = "true"
  }
}

# 3- Deploy private subnets
resource "aws_subnet" "smart_private_subnets" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.smart_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.subnet_new_bits, each.value) # Using a variable for new bits
  availability_zone = each.key
  tags = {
    Name      = "${each.key}_private_subnet"
    Terraform = "true"
  }
}

# 4- Internet Gateway
resource "aws_internet_gateway" "smart_igw" {
  vpc_id = aws_vpc.smart_vpc.id
  tags = {
    Name = "project_igw"
  }
}

# 5- EIP for NAT
resource "aws_eip" "smart_nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.smart_igw]
  tags = {
    Name = "project_igw_eip"
  }
}

# 6- NAT Gateway
resource "aws_nat_gateway" "smart_nat_gateway" {
  depends_on    = [aws_subnet.smart_public_subnets]
  allocation_id = aws_eip.smart_nat_eip.id
  subnet_id     = aws_subnet.smart_public_subnets[var.nat_gateway_subnet_az].id # Use a variable for the NAT Gateway subnet AZ
  tags = {
    Name = "project_nat_gateway"
  }
}

# 7- Route table for private subnets
resource "aws_route_table" "smart_private_rtb" {
  vpc_id = aws_vpc.smart_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.smart_nat_gateway.id
  }
  tags = {
    Name      = "project_private_rtb"
    Terraform = "true"
  }
}

# 8- Route table associations for private subnets
resource "aws_route_table_association" "smart_private_assoc" {
  depends_on     = [aws_subnet.smart_private_subnets]
  route_table_id = aws_route_table.smart_private_rtb.id
  for_each       = aws_subnet.smart_private_subnets
  subnet_id      = each.value.id
}

# 9- Route table for public subnets
resource "aws_route_table" "smart_public_rtb" {
  vpc_id = aws_vpc.smart_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.smart_igw.id
  }
  tags = {
    Name      = "project_public_rtb"
    Terraform = "true"
  }
}

# 10- Route table associations for public subnets
resource "aws_route_table_association" "smart_public_assoc" {
  depends_on     = [aws_subnet.smart_public_subnets]
  route_table_id = aws_route_table.smart_public_rtb.id
  for_each       = aws_subnet.smart_public_subnets
  subnet_id      = each.value.id
}