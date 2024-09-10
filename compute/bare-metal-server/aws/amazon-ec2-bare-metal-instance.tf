
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Security Group for Bare Metal Instance
resource "aws_security_group" "main" {
  name = "bare-metal-sg"
  # Define inbound rules for the security group
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Define outbound rules for the security group
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a Bare Metal Instance
resource "aws_ec2_instance" "main" {
  ami           = "ami-08c40ec972c57421d" # AMI for Ubuntu Server 20.04 LTS
  instance_type = "x1e.32xlarge"          # Bare Metal Instance type
  # Specify the SSH key to access the instance
  key_name = "my-ssh-key"
  # Define tags for the instance
  tags = {
    Name = "My Bare Metal Instance"
  }
  # Specify the security group
  vpc_security_group_ids = [aws_security_group.main.id]

  # Enable Enhanced Networking for Bare Metal Instances
  enhanced_networking = true
}

  