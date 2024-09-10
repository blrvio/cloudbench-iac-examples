
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

# Create a service discovery namespace
resource "aws_service_discovery_namespace" "main" {
  name = "my-namespace"  # Name of the namespace
  # Optional properties
  description = "My service discovery namespace"
  # Create a private namespace (accessible only within the VPC)
  type = "PRIVATE"
  # Define the properties for a private namespace
  properties {
    vpc = aws_vpc.main.id  # The VPC ID for the private namespace
  }
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"  # The CIDR block for the VPC
  # Optional properties
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "My VPC"
  }
}

# Create a service discovery service
resource "aws_service_discovery_service" "main" {
  name    = "my-service"  # Name of the service
  namespace_id = aws_service_discovery_namespace.main.id  # The namespace ID
  # Optional properties
  description = "My service discovery service"
  # Set the service type (HTTP, HTTPS, TCP, UDP, or NONE)
  dns_config {
    dns_records = ["A"]
    # You can specify other DNS record types here
    # For example, "SRV" for a DNS SRV record
  }
  health_check_config {
    failure_threshold = 2  # Number of consecutive failures before the service is considered unhealthy
    # Configure the health check type (HTTP, HTTPS, TCP, or TLS)
    type = "HTTP"
    # Define the health check request and response
    resource_path = "/healthcheck"
  }
}

# Create a service discovery instance
resource "aws_service_discovery_instance" "main" {
  service_id = aws_service_discovery_service.main.id  # The service ID
  # Optional properties
  instance_id = "my-instance"
  # Define the instance attributes (key-value pairs)
  attributes = {
    "AWS_INSTANCE_IPV4" = aws_instance.main.private_ip  # The instance's private IP address
    # You can add other attributes here
  }
}

# Create an EC2 instance (Optional, only if you need to create an EC2 instance for your service)
resource "aws_instance" "main" {
  ami           = "ami-08c40ec972c57421d"  # The AMI ID of the instance
  instance_type = "t2.micro"  # The instance type
  # Define the SSH key to use for accessing the instance
  key_name = "my-ssh-key"
  # Add tags to the instance
  tags = {
    Name = "My EC2 Instance"
  }
  # Define the network configuration for the instance
  # This example uses the default subnet
  vpc_security_group_ids = [aws_security_group.main.id]
}

# Create a security group (Optional, only if you need to create a security group for your instance)
resource "aws_security_group" "main" {
  name   = "sg-ec2"
  # Define the ingress and egress rules for the security group
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

  