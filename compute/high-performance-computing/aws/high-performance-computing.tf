
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  # Enable DNS hostnames and DNS resolution
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "My VPC"
  }
}

# Create a Subnet
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "My Subnet"
  }
}

# Create a Security Group
resource "aws_security_group" "main" {
  name   = "sg-hpc"
  vpc_id = aws_vpc.main.id

  # Allow SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow internal communication within the VPC
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a Launch Template
resource "aws_launch_template" "main" {
  name_prefix   = "hpc-launch-template"
  image_id      = "ami-08c40ec972c57421d" # Ubuntu Server 20.04 LTS
  instance_type = "c5.xlarge"
  key_name      = "my-ssh-key"

  # Assign security group to the launch template
  security_group_ids = [aws_security_group.main.id]

  # Configure the EBS volume
  ebs_block_device {
    device_name           = "/dev/sda1"
    volume_type           = "gp2"
    delete_on_termination = true
    volume_size           = 100
  }

  user_data = <<EOF
#!/bin/bash
# Install and configure HPC software here
EOF
}

# Create an Auto Scaling Group
resource "aws_autoscaling_group" "main" {
  name_prefix         = "hpc-asg"
  vpc_zone_identifier = [aws_subnet.main.id]
  launch_template {
    id = aws_launch_template.main.id
  }
  min_size         = 1
  max_size         = 3
  desired_capacity = 2
}

# Create an Elastic Load Balancer (Optional)
# resource "aws_lb" "main" {
#   name = "hpc-elb"
#   subnets = [aws_subnet.main.id]
#   security_groups = [aws_security_group.main.id]
#   load_balancer_type = "application"
#   # ...
# }
# resource "aws_lb_target_group" "main" {
#   name     = "hpc-target-group"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.main.id
#   # ...
# }
# resource "aws_lb_listener" "main" {
#   load_balancer_arn = aws_lb.main.arn
#   port             = 80
#   protocol          = "HTTP"
#   default_actions {
#     type = "forward"
#     target_group_arn = aws_lb_target_group.main.arn
#   }
# }
# resource "aws_lb_target_group_attachment" "main" {
#   target_group_arn = aws_lb_target_group.main.arn
#   target_id        = aws_autoscaling_group.main.id
#   port             = 80
# }

  