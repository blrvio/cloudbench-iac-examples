
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a security group for the load balancer
resource "aws_security_group" "lb_sg" {
  name = "lb-sg"
  # Define ingress rules for HTTP and HTTPS traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
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

# Create a load balancer
resource "aws_lb" "main" {
  name = "my-load-balancer"
  # Select the desired load balancer type (Application Load Balancer in this case)
  subnets         = [aws_subnet.main.id]
  security_groups = [aws_security_group.lb_sg.id]
  # Enable HTTP and HTTPS listeners
  listener {
    port     = 80
    protocol = "HTTP"
  }
  listener {
    port     = 443
    protocol = "HTTPS"
  }
  # Optionally, define a target group to which the load balancer will route traffic
  # target_group {
  #   name = "my-target-group"
  #   port = 80
  #   protocol = "HTTP"
  #   vpc_id = aws_vpc.main.id
  # }
}

# Create a subnet to host the load balancer
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}


  