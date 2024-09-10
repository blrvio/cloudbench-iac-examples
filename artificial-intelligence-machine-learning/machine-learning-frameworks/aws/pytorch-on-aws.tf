
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an EC2 instance for PyTorch
resource "aws_instance" "pytorch" {
  ami           = "ami-08c40ec972c57421d" # Ubuntu Server 20.04 LTS AMI
  instance_type = "t2.medium" # Choose a suitable instance type
  key_name      = "my-ssh-key" # Replace with your SSH key pair
  tags = {
    Name = "PyTorch Instance"
  }
  # Configure network settings
  vpc_security_group_ids = [aws_security_group.pytorch.id]
}

# Create a security group to allow SSH access
resource "aws_security_group" "pytorch" {
  name   = "sg-pytorch"
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

# (Optional) Create an EBS volume for persistent storage
resource "aws_ebs_volume" "pytorch_storage" {
  availability_zone = "us-east-1a"
  size              = 100
  type              = "gp2"
  tags = {
    Name = "PyTorch Storage"
  }
}

# (Optional) Attach the EBS volume to the EC2 instance
resource "aws_instance_volume_attachment" "pytorch_storage_attach" {
  device_name = "/dev/sdf"
  instance_id = aws_instance.pytorch.id
  volume_id   = aws_ebs_volume.pytorch_storage.id
}

# Install PyTorch on the instance
resource "null_resource" "install_pytorch" {
  provisioner "local-exec" {
    command = "sudo apt update && sudo apt install -y python3-pip && sudo pip3 install torch torchvision torchaudio"
  }
  # You can add more commands to configure your PyTorch environment
  # like installing specific libraries or setting up virtual environments.
}

  