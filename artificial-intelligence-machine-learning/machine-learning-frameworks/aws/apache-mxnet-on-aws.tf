
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an EC2 Instance
resource "aws_instance" "main" {
  ami           = "ami-08c40ec972c57421d" # Ubuntu Server 20.04 LTS AMI
  instance_type = "t2.micro" # Instance type
  # Define the SSH key to be used to access the instance
  key_name = "my-ssh-key"
  # Define tags for the instance
  tags = {
    Name = "My MXNet Instance"
  }

  # Define the network configuration for the instance
  # The instance will be created in the default subnet
  vpc_security_group_ids = [aws_security_group.main.id]
}

# Create a security group
resource "aws_security_group" "main" {
  name   = "sg-mxnet"
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

# Install MXNet on the EC2 instance
resource "null_resource" "install_mxnet" {
  provisioner "local-exec" {
    command = "sudo apt update && sudo apt install -y libopenblas-base libgflags-dev libgtest-dev python3-pip python3-dev && pip3 install mxnet"
  }
  # The connection to the instance will be established using the SSH key
  connection {
    host     = aws_instance.main.public_ip
    user     = "ubuntu" # Default user on Ubuntu
    private_key = file("path/to/your/key.pem")
  }
}

  