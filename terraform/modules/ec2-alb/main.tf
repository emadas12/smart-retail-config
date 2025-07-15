# 11- Security Group for EC2
resource "aws_security_group" "smart_web_sg" {
  name   = "WebSG"
  vpc_id = var.vpc_id
  dynamic "ingress" {
    for_each = var.allowed_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Web_Instance_Security_Group"
  }
}

# 12- Key Pair
resource "aws_key_pair" "smart_key_pair" {
  key_name   = var.key_pair_name
  public_key = file("~/.ssh/${var.key_pair_name}.pub") # Assumes key is in ~/.ssh/
}

# 13- EC2 Instances
resource "aws_instance" "smart_web_instance" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  availability_zone      = var.web_instance_az
  vpc_security_group_ids = [aws_security_group.smart_web_sg.id]
  subnet_id              = var.private_subnet_ids[0] # Assuming first private subnet is in us-east-1a
  root_block_device { encrypted = true }
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd
    echo "This is server *1*" > /var/www/html/index.html
    EOF
  tags = {
    Name = "web_instance"
  }
}

resource "aws_instance" "smart_app_instance" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  availability_zone      = var.app_instance_az
  vpc_security_group_ids = [aws_security_group.smart_web_sg.id]
  subnet_id              = var.private_subnet_ids[1] # Assuming second private subnet is in us-east-1b
  root_block_device { encrypted = true }
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd
    echo "This is server *2*" > /var/www/html/index.html
    EOF
  tags = {
    Name = "app_instance"
  }
}

# 14- ALB Security Group
resource "aws_security_group" "smart_alb_sg" {
  name        = "ALBSG"
  description = "security group for alb"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.smart_web_sg.id]
  }
  tags = {
    Name = "ALB_Security_Group"
  }
}

# 15- ALB
resource "aws_lb" "smart_alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.smart_alb_sg.id]
  subnets            = var.public_subnet_ids # list of public subnet IDs
  tags = {
    Name = "Application_Load_Balancer"
  }
}

# 16- Target Group
resource "aws_lb_target_group" "smart_tg" {
  name     = "project-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags = {
    Name = "Project_Target_Group"
  }
}

resource "aws_lb_target_group_attachment" "smart_attach_web" {
  target_group_arn = aws_lb_target_group.smart_tg.arn
  target_id        = aws_instance.smart_web_instance.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "smart_attach_app" {
  target_group_arn = aws_lb_target_group.smart_tg.arn
  target_id        = aws_instance.smart_app_instance.id
  port             = 80
}

# 17- Listener
resource "aws_lb_listener" "smart_listener" {
  load_balancer_arn = aws_lb.smart_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.smart_tg.arn
  }
  tags = {
    Name = "ALB_HTTP_Listener"
  }
}

# 18- Launch Config
resource "aws_launch_configuration" "smart_launch_config" {
  name_prefix     = "smart-launch-instance"
  image_id        = var.instance_ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.smart_web_sg.id]
  lifecycle {
    create_before_destroy = true
  }
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd
    echo "This is an ASG instance" > /var/www/html/index.html
    EOF
}

# 19- Auto Scaling Group
resource "aws_autoscaling_group" "smart_asg" {
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.smart_launch_config.name
  vpc_zone_identifier  = var.private_subnet_ids # the list of private subnet IDs
  tags = [
    {
      key                 = "Name"
      value               = "ASG_Instance"
      propagate_at_launch = true
    }
  ]
}

# 20- Attach ASG to ALB
resource "aws_autoscaling_attachment" "smart_asg_attach" {
  autoscaling_group_name = aws_autoscaling_group.smart_asg.id
  lb_target_group_arn    = aws_lb_target_group.smart_tg.arn
}