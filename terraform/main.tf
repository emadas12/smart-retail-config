# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
  profile = "dev_admin" 
}

# Call the VPC module
module "network" {
  source           = "./modules/vpc"
  vpc_cidr         = var.vpc_cidr
  vpc_name         = var.vpc_name
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
}

# Call the EC2/ALB module
module "web_app" {
  source                   = "./modules/ec2-alb"
  vpc_id                   = module.network.vpc_id
  public_subnet_ids        = values(module.network.public_subnet_ids)
  private_subnet_ids       = values(module.network.private_subnet_ids)
  allowed_ports            = var.allowed_ports
  key_pair_name            = var.key_pair_name
  instance_ami             = var.instance_ami
  instance_type            = var.instance_type
  web_instance_az          = "us-east-1a" 
  app_instance_az          = "us-east-1b"
}

# Call the RDS module
module "database" {
  source                   = "./modules/rds"
  vpc_id                   = module.network.vpc_id
  private_subnet_ids       = values(module.network.private_subnet_ids)
  rds_allocated_storage    = var.rds_allocated_storage
  rds_engine               = var.rds_engine
  rds_engine_version       = var.rds_engine_version
  rds_instance_class       = var.rds_instance_class
  rds_db_name              = var.rds_db_name
  rds_username             = var.rds_username
  rds_password             = var.rds_password
  web_sg_id                = module.web_app.web_sg_id
}