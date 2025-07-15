output "vpc_id" {
  description = "The ID of the created VPC."
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = module.network.private_subnet_ids
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer."
  value       = module.web_app.alb_dns_name
}

output "rds_endpoint" {
  description = "The endpoint address of the RDS instance."
  value       = module.database.rds_endpoint
}