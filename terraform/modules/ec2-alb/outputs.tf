output "web_sg_id" {
  description = "The ID of the web security group."
  value       = aws_security_group.smart_web_sg.id
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer."
  value       = aws_lb.smart_alb.dns_name
}