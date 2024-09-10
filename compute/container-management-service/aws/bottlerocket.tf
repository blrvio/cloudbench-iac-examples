
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Bottlerocket AMI
resource "aws_ec2_ami" "main" {
  name    = "bottlerocket-ami"
  description = "Bottlerocket AMI for testing"
  # Use the Bottlerocket AMI from the AWS Marketplace
  source_ami_id = "ami-0567a9548067f23e9"
  # Configure the AMI settings
  root_device_name = "/dev/xvda"
  # Optional: Add tags to the AMI
  tags = {
    Name = "Bottlerocket AMI"
  }
}

# Create an EC2 instance using the Bottlerocket AMI
resource "aws_instance" "main" {
  ami           = aws_ec2_ami.main.id
  instance_type = "t2.micro" # Choose an instance type
  # Define the SSH key to be used to access the instance
  key_name = "my-ssh-key"
  # Define tags for the instance
  tags = {
    Name = "Bottlerocket Instance"
  }

  # Define the network settings for the instance
  # The instance will be created in the default subnet
  vpc_security_group_ids = [aws_security_group.main.id]
}

# Create a security group
resource "aws_security_group" "main" {
  name   = "sg-bottlerocket"
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
  