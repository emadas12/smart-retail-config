output "vpc_id" {
  description = "The ID of the created VPC."
  value       = aws_vpc.smart_vpc.id
}

output "public_subnet_ids" {
  description = "A map of public subnet IDs keyed by availability zone."
  value       = { for az, subnet in aws_subnet.smart_public_subnets : az => subnet.id }
}

output "private_subnet_ids" {
  description = "A map of private subnet IDs keyed by availability zone."
  value       = { for az, subnet in aws_subnet.smart_private_subnets : az => subnet.id }
}