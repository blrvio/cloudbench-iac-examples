
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a NICE DCV endpoint
resource "aws_dcv_endpoint" "main" {
  name = "my-dcv-endpoint"
  # Select the desired NICE DCV instance type
  instance_type = "dcv-g4dn.xlarge"
  # Configure the desired subnet for the endpoint
  subnet_id = "subnet-0123456789abcdef0"
  # Configure the VPC security group for the endpoint
  security_group_ids = [aws_security_group.main.id]
}

# Create a security group for the NICE DCV endpoint
resource "aws_security_group" "main" {
  name = "sg-dcv-endpoint"
  # Define the inbound and outbound rules for the security group
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

# Create a NICE DCV streaming session
resource "aws_dcv_streaming_session" "main" {
  endpoint_id = aws_dcv_endpoint.main.id
  # Define the session name
  name = "my-dcv-session"
  # Configure the session's display properties
  display {
    width  = 1920
    height = 1080
  }
  # Define the session's access policy
  access_policy = "public"
}

  