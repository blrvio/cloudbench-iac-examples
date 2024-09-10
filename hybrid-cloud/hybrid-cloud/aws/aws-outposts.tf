
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Outposts Location
resource "aws_outposts_location" "main" {
  name    = "my-outposts-location"
  region  = "us-east-1"           # Replace with the desired region
  site_id = "my-outposts-site-id" # Replace with your Outposts Site ID
}

# Create an Outposts Instance
resource "aws_outposts_instance" "main" {
  availability_zone = "us-east-1a" # Replace with your desired availability zone
  instance_type     = "m5.large"   # Replace with your desired instance type
  location_id       = aws_outposts_location.main.id
  subnet_id         = "subnet-0123456789abcdef0" # Replace with the subnet ID of your Outposts VPC
  # Add tags to your Outposts instance
  tags = {
    Name = "My Outposts Instance"
  }
}

# Create an Outposts Security Group
resource "aws_outposts_security_group" "main" {
  description = "My Outposts Security Group"
  name        = "my-outposts-security-group"
  location_id = aws_outposts_location.main.id

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

  