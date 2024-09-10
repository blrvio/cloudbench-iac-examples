
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Launch Configuration
resource "aws_launch_configuration" "main" {
  name_prefix  = "my-autoscaling-lc-"
  image_id     = "ami-08c40ec972c57421d" # Ubuntu Server 20.04 LTS AMI
  instance_type = "t2.micro" # Instance type
  # Set the SSH key that will be used to access the instances
  key_name = "my-ssh-key"
  # Set tags for the instances
  user_data = <<EOF
#!/bin/bash
# Install required packages
# ...
EOF
  # Set the security group for the instances
  security_groups = [aws_security_group.main.id]
}

# Create a Security Group
resource "aws_security_group" "main" {
  name   = "sg-autoscaling"
  # Define the ingress and egress rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an Auto Scaling Group
resource "aws_autoscaling_group" "main" {
  name           = "my-autoscaling-group"
  vpc_zone_identifier = [aws_subnet.main.id] # Replace with your subnet ID
  launch_configuration = aws_launch_configuration.main.name
  min_size        = 1 # Minimum number of instances
  max_size        = 3 # Maximum number of instances
  desired_capacity = 2 # Desired number of instances
  # Set the cooldown period for the group
  cooldown = "300"
  # Set the health check type for the group
  health_check_type = "EC2"
  # Set the health check grace period
  health_check_grace_period = "300"
  # Set the tags for the group
  tags = {
    Name = "My Auto Scaling Group"
  }
}

# Create a subnet
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block         = "10.0.0.0/24" # Replace with your subnet CIDR block
  availability_zone = "us-east-1a" # Replace with your desired availability zone
  # Set the tags for the subnet
  tags = {
    Name = "My Subnet"
  }
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16" # Replace with your desired CIDR block
  # Set the tags for the VPC
  tags = {
    Name = "My VPC"
  }
}

  