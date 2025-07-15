output "rds_endpoint" {
  description = "The connection endpoint of the RDS instance."
  value       = aws_db_instance.smart_rds.address
}

output "rds_sg_id" {
  description = "The ID of the RDS security group."
  value       = aws_security_group.smart_db_sg.id
}