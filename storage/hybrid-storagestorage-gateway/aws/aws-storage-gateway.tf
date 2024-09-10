
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Storage Gateway
resource "aws_storagegateway_gateway" "main" {
  gateway_name = "my-storage-gateway" # Name of your Storage Gateway
  gateway_type  = "CACHED" # Type of Storage Gateway (CACHED, STORED, or FILE_GATEWAY)
  # Define the VPC configuration for the Storage Gateway
  vpc_endpoint { # For cached or stored gateways
    subnet_id = aws_subnet.main.id # ID of the subnet in your VPC
    security_groups = [aws_security_group.main.id] # Security groups associated with the VPC
  }
  # Optionally define the location of the Storage Gateway
  # location_arn = "arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678" # ARN of the location
}

# Create a subnet in your VPC
resource "aws_subnet" "main" {
  cidr_block = "10.0.1.0/24" # CIDR block for the subnet
  availability_zone = "us-east-1a" # Availability zone for the subnet
  vpc_id        = "vpc-123456789012" # ID of the VPC
}

# Create a security group for the Storage Gateway
resource "aws_security_group" "main" {
  name   = "sg-storage-gateway"
  # Define the ingress and egress rules
  ingress {
    from_port   = 443 # Port for HTTPS traffic
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow access from anywhere
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow access from anywhere
  }
}

# Create a volume on the Storage Gateway
resource "aws_storagegateway_volume" "main" {
  gateway_arn = aws_storagegateway_gateway.main.arn
  volume_type  = "CACHED" # Type of volume (CACHED or STORED)
  # Optional volume settings
  # source_volume_arn = "arn:aws:ec2:us-east-1:123456789012:volume/vol-1234567890abcdef0" # ARN of the source volume for stored volumes
  # disk_id         = "disk1" # Disk ID for file gateway volumes
}

# Configure the Storage Gateway endpoint
resource "aws_storagegateway_endpoint" "main" {
  gateway_arn = aws_storagegateway_gateway.main.arn
  endpoint_type = "FILE_SHARE" # Type of endpoint (FILE_SHARE or S3)
  # Optionally define the file share settings
  #  file_share { # For FILE_SHARE endpoints
  #    location_arn = "arn:aws:storagegateway:us-east-1:123456789012:gateway/sgw-12345678/share/shr-12345678" # ARN of the file share
  #    access_control { # Access control settings
  #      access_based_enumeration = "ENABLED" # Enables access-based enumeration
  #      user_access_type = "USER_ACCESSIBLE" # User access type (USER_ACCESSIBLE, ADMIN_ACCESSIBLE, or DENIED)
  #    }
  #  }
  #  s3 { # For S3 endpoints
  #    s3_bucket_name = "my-s3-bucket" # Name of the S3 bucket
  #    s3_prefix = "my-prefix" # Prefix for objects in the S3 bucket
  #  }
}

  