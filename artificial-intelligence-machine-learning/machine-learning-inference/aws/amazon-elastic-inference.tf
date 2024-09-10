
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Elastic Inference Accelerator
resource "aws_elastic_inference_accelerator" "main" {
  accelerator_type = "eia1.small"
  #  Define the Elastic Inference Accelerator type. 
  #  Example: eia1.small, eia1.medium, eia1.large, eia1.xlarge
  #  Note: Available types may vary by region.
  
  #  You can specify optional tags for the Accelerator
  tags = {
    Name = "My Elastic Inference Accelerator"
  }
}

# Create an EC2 Instance with Elastic Inference
resource "aws_instance" "main" {
  ami           = "ami-08c40ec972c57421d" # Ubuntu Server 20.04 LTS AMI
  instance_type = "t2.micro" # Instance type
  #  Specify the Elastic Inference Accelerator to attach
  elastic_inference_accelerator_type = "eia1.small"
  #  Define the Elastic Inference Accelerator type. 
  #  Example: eia1.small, eia1.medium, eia1.large, eia1.xlarge
  #  Note: Available types may vary by region.
  
  #  Define the key pair to use for SSH access
  key_name = "my-ssh-key"
  
  #  Define the security group for the instance
  vpc_security_group_ids = [aws_security_group.main.id]
  
  #  Specify optional tags for the instance
  tags = {
    Name = "My EC2 Instance"
  }
}

# Create a security group for the EC2 Instance
resource "aws_security_group" "main" {
  name   = "sg-ec2"
  #  Define ingress and egress rules for the security group
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

  