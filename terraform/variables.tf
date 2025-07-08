variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The name tag for the VPC."
  type        = string
  default     = "smart_project_vpc"
}

variable "public_subnets" {
  description = "A map of public subnet availability zones and their corresponding CIDR host bits for cidrsubnet function."
  type        = map(number)
  default = {
    "us-east-1a" = 0
    "us-east-1b" = 1
  }
}

variable "private_subnets" {
  description = "A map of private subnet availability zones and their corresponding CIDR host bits for cidrsubnet function."
  type        = map(number)
  default = {
    "us-east-1a" = 2
    "us-east-1b" = 3
  }
}

variable "allowed_ports" {
  description = "List of ports to open on the web security group."
  type        = list(number)
  default     = [80, 22] # HTTP and SSH
}

variable "key_pair_name" {
  description = "The name of the AWS Key Pair to use for EC2 instances."
  type        = string
  default     = "MyKey"
}

variable "instance_ami" {
  description = "The AMI ID for the EC2 instances."
  type        = string
  default     = "ami-0dfcb1ef8550277af" 
}

variable "instance_type" {
  description = "The instance type for the EC2 instances."
  type        = string
  default     = "t2.micro"
}

variable "rds_allocated_storage" {
  description = "The allocated storage in GB for the RDS instance."
  type        = number
  default     = 20
}

variable "rds_engine" {
  description = "The database engine for the RDS instance."
  type        = string
  default     = "mysql"
}

variable "rds_engine_version" {
  description = "The database engine version for the RDS instance."
  type        = string
  default     = "8.0.27"
}

variable "rds_instance_class" {
  description = "The instance class for the RDS instance."
  type        = string
  default     = "db.t2.micro"
}

variable "rds_db_name" {
  description = "The name of the database to create."
  type        = string
  default     = "project_rds"
}

variable "rds_username" {
  description = "The username for the RDS database."
  type        = string
  default     = "dolfined"
  sensitive   = true 
}

variable "rds_password" {
  description = "The password for the RDS database."
  type        = string
  default     = "dolfined" 
  sensitive   = true       
}