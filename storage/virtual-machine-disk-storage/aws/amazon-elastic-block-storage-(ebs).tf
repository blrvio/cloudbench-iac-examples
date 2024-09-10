
# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an EBS volume
resource "aws_ebs_volume" "main" {
  availability_zone = "us-east-1a" # Select an availability zone
  size              = 10           # Volume size in GB
  type              = "gp2"        # Volume type (GP2)
  # Add tags to the volume
  tags = {
    Name = "My EBS Volume"
  }
}

# Attach the EBS volume to an EC2 instance
# You'll need to define an EC2 instance resource first
# For example:
resource "aws_instance" "main" {
  # ...
}
resource "aws_instance_volume_attachment" "main" {
  device_name = "/dev/sdf"
  instance_id = aws_instance.main.id
  volume_id   = aws_ebs_volume.main.id
}

  