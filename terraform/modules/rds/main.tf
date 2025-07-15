# 21- RDS Subnet Group
resource "aws_db_subnet_group" "smart_db_subnet" {
  name       = "rds-db-subnet"
  subnet_ids = var.private_subnet_ids
  tags = {
    Name = "Project_RDS_Subnet_Group"
  }
}

# 22- RDS SG
resource "aws_security_group" "smart_db_sg" {
  name        = "db-sg"
  description = "security group for RDS database"
  vpc_id      = var.vpc_id
  ingress {
    from_port       = 3306 # MySQL default port
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.web_sg_id] # Allow traffic from the web security group
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "RDS_Security_Group"
  }
}

# 23- RDS
resource "aws_db_instance" "smart_rds" {
  allocated_storage      = var.rds_allocated_storage
  identifier             = "rds-terraform"
  storage_type           = "gp2"
  engine                 = var.rds_engine
  engine_version         = var.rds_engine_version
  instance_class         = var.rds_instance_class
  db_name                = var.rds_db_name
  username               = var.rds_username
  password               = var.rds_password
  publicly_accessible    = false
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.smart_db_subnet.name # name here
  vpc_security_group_ids = [aws_security_group.smart_db_sg.id]
  tags = {
    Name = "ExampleRDSServerInstance"
  }
}