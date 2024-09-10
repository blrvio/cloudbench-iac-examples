
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an EC2 instance
resource "aws_instance" "main" {
  ami           = "ami-08c40ec972c57421d" # Ubuntu Server 20.04 LTS AMI
  instance_type = "t2.micro" # Instance type
  # Define the SSH key that will be used to access the instance
  key_name = "my-ssh-key"
  # Define tags for the instance
  tags = {
    Name = "My EC2 Instance"
  }

  # Define the network configuration of the instance
  # The instance will be created in the default subnet
  vpc_security_group_ids = [aws_security_group.main.id]
}

# Create a security group
resource "aws_security_group" "main" {
  name   = "sg-ec2"
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

# Create an EBS volume
resource "aws_ebs_volume" "main" {
  availability_zone = "us-east-1a" # Select an availability zone
  size              = 10 # Volume size in GB
  type              = "gp2" # Volume type (GP2)
  # Add tags to the volume
  tags = {
    Name = "My EBS Volume"
  }
}

# Create an attachment point for the EBS volume
resource "aws_instance_volume_attachment" "main" {
  device_name = "/dev/sdf"
  instance_id = aws_instance.main.id
  volume_id   = aws_ebs_volume.main.id
}

  