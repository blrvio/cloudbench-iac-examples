
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Microsoft AD Directory
resource "aws_directory_service_directory" "main" {
  name = "my-ad-directory" # Name for your AD directory
  # Set the edition of the directory
  edition = "Standard"
  # Define the password for the directory administrator
  password = "MyStrongPassword123" # Replace with a strong password
  # Choose the type of directory
  type = "MicrosoftAD"
  # Configure the subnet where the directory will be hosted
  # The directory will be created in the default subnet
  vpc_settings {
    subnet_ids = [aws_subnet.main.id]
  }
  # Set the desired size of the directory
  size = "Small"
}

# Create a subnet for the directory
resource "aws_subnet" "main" {
  # Replace with your VPC ID
  vpc_id = "vpc-1234567890abcdef0"
  # Select an availability zone
  availability_zone = "us-east-1a"
  # CIDR block for the subnet
  cidr_block = "10.0.1.0/24"
}

# Create a security group for the directory
resource "aws_security_group" "main" {
  name = "sg-ad-directory"
  # Configure the inbound rules for the security group
  ingress {
    from_port   = 389 # LDAP port
    to_port     = 389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Configure the outbound rules for the security group
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
  