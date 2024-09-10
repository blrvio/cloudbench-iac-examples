
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an FSx for OpenZFS file system
resource "aws_fsx_openzfs_file_system" "main" {
  storage_capacity = 1024 # Size of the file system in GiB
  #  Use a subnet in a VPC to host your file system
  subnet_ids = [aws_subnet.main.id]
  #  Select the type of file system
  storage_type = "SSD"
  #  Select the provisioned throughput for the file system
  throughput_capacity = 128
  #  The security group IDs of the security groups to use for the file system
  security_group_ids = [aws_security_group.main.id]
  #  Specify the backup policy for the file system
  backup_policy {
    automatic_backup_interval_hours = 24
    #  Delete backups after a specific number of days
    retention_days = 7
    #  Configure the backup policy
    backup_type = "USER_MANAGED"
    #  Add tags for the file system
    tags = {
      Name = "My FSx for OpenZFS File System"
    }
  }
}

# Create a subnet for the file system
resource "aws_subnet" "main" {
  availability_zone = "us-east-1a" # Select an Availability Zone
  cidr_block         = "10.0.0.0/24" # Specify a CIDR block for the subnet
  vpc_id            = aws_vpc.main.id # ID of the VPC
}

# Create a VPC for the file system
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16" # Specify a CIDR block for the VPC
  #  Add tags for the VPC
  tags = {
    Name = "My VPC"
  }
}

# Create a security group for the file system
resource "aws_security_group" "main" {
  name   = "sg-fsx-openzfs"
  #  Define inbound and outbound rules for the security group
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

  