
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Dedicated Host
resource "aws_ec2_dedicated_host" "main" {
  auto_placement = "on" # Automatically place instances on the host
  host_type = "m5.xlarge" # Host type to use (e.g., m5.xlarge, m5n.xlarge, etc.)
  instance_family = "m5" # Instance family to use
  availability_zone = "us-east-1a" # Availability Zone for the host
  # Define the host attributes
  host_properties {
    instance_type = "m5.xlarge" # Instance type to use
  }
}

# Create a Security Group
resource "aws_security_group" "main" {
  name   = "sg-dedicated-host"
  # Define the ingress and egress rules
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

# Create an EC2 instance on the Dedicated Host
resource "aws_instance" "main" {
  ami           = "ami-08c40ec972c57421d" # Ubuntu Server 20.04 LTS AMI
  instance_type = "m5.xlarge" # Instance type to use
  # Define the SSH key to use for accessing the instance
  key_name = "my-ssh-key"
  # Define the tags for the instance
  tags = {
    Name = "My EC2 Instance on Dedicated Host"
  }
  # Attach the Dedicated Host to the instance
  dedicated_host_id = aws_ec2_dedicated_host.main.id
  # Define the network settings for the instance
  vpc_security_group_ids = [aws_security_group.main.id]
}

  