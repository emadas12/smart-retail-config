variable "vpc_id" {
  description = "The ID of the VPC to deploy resources into."
  type        = string
}

variable "public_subnet_ids" {
  description = "A list of public subnet IDs for the ALB."
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs for the EC2 instances and ASG."
  type        = list(string)
}

variable "allowed_ports" {
  description = "List of ports to open on the web security group."
  type        = list(number)
}

variable "key_pair_name" {
  description = "The name of the AWS Key Pair to use for EC2 instances."
  type        = string
}

variable "instance_ami" {
  description = "The AMI ID for the EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instances."
  type        = string
}

variable "web_instance_az" {
  description = "Availability Zone for the web instance."
  type        = string
}

variable "app_instance_az" {
  description = "Availability Zone for the app instance."
  type        = string
}