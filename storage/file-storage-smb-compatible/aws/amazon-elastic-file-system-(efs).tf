
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an EFS File System
resource "aws_efs_file_system" "main" {
  # Name of the file system
  name = "my-efs-file-system"
  # Set the performance mode of the file system. Possible values are "generalPurpose" (default), "maxIO" and "throughputOptimized"
  performance_mode = "generalPurpose"
  # The throughput mode to set for the file system. Possible values are "bursting" (default) and "provisioned".
  throughput_mode = "bursting"
  # The tags to apply to the file system
  tags = {
    Name = "My EFS File System"
  }
}

# Create an EFS Mount Target
resource "aws_efs_mount_target" "main" {
  # ID of the file system
  file_system_id = aws_efs_file_system.main.id
  # ID of the subnet where the mount target is to be created
  subnet_id = aws_subnet.main.id
  # The security groups that are to be associated with the mount target
  security_groups = [aws_security_group.main.id]
}

# Create a subnet for the mount target
resource "aws_subnet" "main" {
  # ID of the VPC
  vpc_id = aws_vpc.main.id
  # CIDR block for the subnet
  cidr_block = "10.0.1.0/24"
  # Availability zone
  availability_zone = "us-east-1a"
  # The tags to apply to the subnet
  tags = {
    Name = "My EFS Subnet"
  }
}

# Create a VPC for the mount target
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  # The tags to apply to the VPC
  tags = {
    Name = "My EFS VPC"
  }
}

# Create a security group for the mount target
resource "aws_security_group" "main" {
  # Name of the security group
  name   = "sg-efs"
  # VPC ID
  vpc_id = aws_vpc.main.id
  # Define ingress and egress rules
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

  