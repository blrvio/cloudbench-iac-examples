
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a VPC Endpoint Service
resource "aws_vpc_endpoint_service" "main" {
  acceptance_required = false
  # Specify the service you want to access via Private Link
  service_name = "com.amazonaws.us-east-1.ecs" # Example: Amazon ECS in us-east-1
  # Optional: Customize the service name prefix
  service_name_prefix = "my-private-link-service"
  # Add tags to the VPC Endpoint Service
  tags = {
    Name = "My Private Link Service"
  }
}

# Create a VPC Endpoint
resource "aws_vpc_endpoint" "main" {
  # Specify the VPC and subnet where you want to create the endpoint
  vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.main.id]
  # Specify the VPC Endpoint Service to connect to
  service_name = aws_vpc_endpoint_service.main.service_name
  # Add tags to the VPC Endpoint
  tags = {
    Name = "My Private Link Endpoint"
  }
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  # Add tags to the VPC
  tags = {
    Name = "My VPC"
  }
}

# Create a Subnet
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  # Choose an Availability Zone
  availability_zone = "us-east-1a"
  # Add tags to the subnet
  tags = {
    Name = "My Subnet"
  }
}

  