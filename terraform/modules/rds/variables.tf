variable "vpc_id" {
  description = "The ID of the VPC for the RDS instance."
  type        = string
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs for the RDS subnet group."
  type        = list(string)
}

variable "rds_allocated_storage" {
  description = "The allocated storage in GB for the RDS instance."
  type        = number
}

variable "rds_engine" {
  description = "The database engine for the RDS instance."
  type        = string
}

variable "rds_engine_version" {
  description = "The database engine version for the RDS instance."
  type        = string
}

variable "rds_instance_class" {
  description = "The instance class for the RDS instance."
  type        = string
}

variable "rds_db_name" {
  description = "The name of the database to create."
  type        = string
}

variable "rds_username" {
  description = "The username for the RDS database."
  type        = string
  sensitive   = true
}

variable "rds_password" {
  description = "The password for the RDS database."
  type        = string
  sensitive   = true
}

variable "web_sg_id" {
  description = "The security group ID of the web instances to allow access to the RDS instance."
  type        = string
}