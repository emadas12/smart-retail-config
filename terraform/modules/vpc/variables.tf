variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "vpc_name" {
  description = "The name tag for the VPC."
  type        = string
}

variable "public_subnets" {
  description = "A map of public subnet availability zones and their corresponding CIDR host bits for cidrsubnet function."
  type        = map(number)
}

variable "private_subnets" {
  description = "A map of private subnet availability zones and their corresponding CIDR host bits for cidrsubnet function."
  type        = map(number)
}

variable "subnet_new_bits" {
  description = "The number of additional bits to use for subnetting the VPC CIDR."
  type        = number
  default     = 8 # From cidrsubnet(var.vpc_cidr, 8, ...) in my original code
}

variable "nat_gateway_subnet_az" {
  description = "The Availability Zone of the public subnet where the NAT Gateway will be deployed."
  type        = string
  default     = "us-east-1a" # my original code used us-east-1a
}