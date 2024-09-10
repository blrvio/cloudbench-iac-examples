
# The AWS Management Console is a web-based interface for managing AWS services. 
# It's not possible to directly manage the Console using Terraform.
# You can use Terraform to manage the resources that are accessed through the Console.
# For example, you can create EC2 instances, S3 buckets, and other resources.
# Terraform provides a set of resources for managing these services.

# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an EC2 instance
resource "aws_instance" "main" {
  ami           = "ami-08c40ec972c57421d" # Ubuntu Server 20.04 LTS AMI
  instance_type = "t2.micro"              # Instance type
  # Define the SSH key that will be used to access the instance
  key_name = "my-ssh-key"
  # Define tags for the instance
  tags = {
    Name = "My EC2 Instance"
  }

  # Define the network settings for the instance
  # The instance will be created in the default subnet
  vpc_security_group_ids = [aws_security_group.main.id]
}

# Create a security group
resource "aws_security_group" "main" {
  name = "sg-ec2"
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

  