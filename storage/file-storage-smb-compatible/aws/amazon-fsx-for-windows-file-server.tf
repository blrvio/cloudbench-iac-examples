
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an FSx for Windows File Server
resource "aws_fsx_windows_file_system" "main" {
  # The name of the file system.
  name = "my-fsx-windows-file-system"

  # The storage capacity (GiB) of the file system.
  storage_capacity = 1024

  # The ID of the subnet in which the file system will be created.
  subnet_ids = [aws_subnet.main.id]

  # The security group IDs to associate with the file system.
  security_group_ids = [aws_security_group.main.id]

  # The version of the Windows Server operating system to use for the file system.
  windows_file_system_configuration {
    # Choose the version of Windows Server you want to use.
    # Available options are "WindowsServer2019" or "WindowsServer2022"
    windows_version = "WindowsServer2019"
  }

  # Tags to apply to the FSx file system.
  tags = {
    Name = "My FSx for Windows File System"
  }
}

# Create a subnet for the file system to be created in
resource "aws_subnet" "main" {
  # The VPC in which the subnet will be created.
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "10.0.0.0/24"

  # The Availability Zone in which the subnet will be created.
  availability_zone = "us-east-1a"
}

# Create a VPC for the file system to be created in
resource "aws_vpc" "main" {
  # The CIDR block for the VPC.
  cidr_block = "10.0.0.0/16"

  # Tags to apply to the VPC
  tags = {
    Name = "My VPC"
  }
}

# Create a security group for the file system
resource "aws_security_group" "main" {
  # The name of the security group.
  name = "sg-fsx-windows"

  # The description of the security group.
  description = "Security group for FSx for Windows File Server"

  # The VPC in which the security group will be created.
  vpc_id = aws_vpc.main.id

  # The ingress rules for the security group.
  ingress {
    # Allow inbound traffic from all sources on port 445 (SMB).
    from_port   = 445
    to_port     = 445
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # The egress rules for the security group.
  egress {
    # Allow outbound traffic to all destinations on all ports.
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  