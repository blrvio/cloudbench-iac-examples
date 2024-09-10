
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an FSx for NetApp ONTAP File System
resource "aws_fsx_ontap_file_system" "main" {
  storage_capacity  = 1024 # Storage capacity in GB
  subnet_ids       = [aws_subnet.main.id] # Subnet IDs for the file system
  security_group_ids = [aws_security_group.main.id] # Security groups for the file system
  kms_key_id       = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012" # KMS key for encryption
  # Optional settings
  throughput_capacity  = 128 # Throughput capacity in MB/s
  deployment_type = "SINGLE_AZ_1" # Deployment type (SINGLE_AZ_1 or MULTI_AZ_1)
  version         = "ONTAP_9_9_1" # ONTAP version
  # Tags for the file system
  tags = {
    Name = "My FSx for NetApp ONTAP File System"
  }
}

# Create a Subnet
resource "aws_subnet" "main" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  # Optional settings
  map_public_ip_on_launch = false
  # Tags for the subnet
  tags = {
    Name = "My FSx for NetApp ONTAP Subnet"
  }
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  # Optional settings
  enable_dns_hostnames = true
  enable_dns_support = true
  # Tags for the VPC
  tags = {
    Name = "My FSx for NetApp ONTAP VPC"
  }
}

# Create a Security Group
resource "aws_security_group" "main" {
  name   = "sg-fsx-ontap"
  # Define inbound and outbound rules
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

  