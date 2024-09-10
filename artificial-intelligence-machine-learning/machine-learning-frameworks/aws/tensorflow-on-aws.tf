
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Amazon EC2 instance for TensorFlow
resource "aws_instance" "tensorflow_instance" {
  ami           = "ami-08c40ec972c57421d" # Ubuntu Server 20.04 LTS AMI
  instance_type = "t2.medium" # Adjust instance type as needed
  key_name      = "your_ssh_key_pair_name" # Replace with your SSH key pair name
  # Define tags for the instance
  tags = {
    Name = "TensorFlow Instance"
  }
  # Define the network settings for the instance
  # The instance will be created in the default subnet
  vpc_security_group_ids = [aws_security_group.tensorflow_sg.id]
}

# Create a Security Group for TensorFlow
resource "aws_security_group" "tensorflow_sg" {
  name = "sg-tensorflow"
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

# Configure an EBS volume for TensorFlow
resource "aws_ebs_volume" "tensorflow_volume" {
  availability_zone = "us-east-1a" # Select an availability zone
  size              = 100 # Volume size in GB
  type              = "gp2" # Volume type (GP2)
  # Add tags to the volume
  tags = {
    Name = "TensorFlow Volume"
  }
}

# Attach the EBS volume to the instance
resource "aws_instance_volume_attachment" "tensorflow_volume_attachment" {
  device_name = "/dev/sdf"
  instance_id = aws_instance.tensorflow_instance.id
  volume_id   = aws_ebs_volume.tensorflow_volume.id
}

# Configure a role for the EC2 instance to access AWS resources
resource "aws_iam_role" "tensorflow_role" {
  name = "tensorflow-ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Add permissions to the role for accessing S3 and other required services
resource "aws_iam_role_policy" "tensorflow_policy" {
  name = "tensorflow-ec2-policy"
  role = aws_iam_role.tensorflow_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
        # Add other necessary actions for your use case
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach the role to the EC2 instance
resource "aws_instance" "tensorflow_instance_with_role" {
  ami           = "ami-08c40ec972c57421d" # Ubuntu Server 20.04 LTS AMI
  instance_type = "t2.medium" # Adjust instance type as needed
  key_name      = "your_ssh_key_pair_name" # Replace with your SSH key pair name
  # Define tags for the instance
  tags = {
    Name = "TensorFlow Instance"
  }
  # Define the network settings for the instance
  # The instance will be created in the default subnet
  vpc_security_group_ids = [aws_security_group.tensorflow_sg.id]
  # Attach the IAM role to the instance
  iam_instance_profile = aws_iam_instance_profile.tensorflow_profile.id
}

# Create an IAM instance profile to associate the role with the instance
resource "aws_iam_instance_profile" "tensorflow_profile" {
  name = "tensorflow-ec2-profile"
  role = aws_iam_role.tensorflow_role.id
}

# Configure a user data script for the instance to install TensorFlow and dependencies
resource "aws_instance" "tensorflow_instance_with_user_data" {
  ami           = "ami-08c40ec972c57421d" # Ubuntu Server 20.04 LTS AMI
  instance_type = "t2.medium" # Adjust instance type as needed
  key_name      = "your_ssh_key_pair_name" # Replace with your SSH key pair name
  # Define tags for the instance
  tags = {
    Name = "TensorFlow Instance"
  }
  # Define the network settings for the instance
  # The instance will be created in the default subnet
  vpc_security_group_ids = [aws_security_group.tensorflow_sg.id]
  # Attach the IAM role to the instance
  iam_instance_profile = aws_iam_instance_profile.tensorflow_profile.id
  # User data script for installing TensorFlow
  user_data = <<EOF
#!/bin/bash
# Update package lists
  sudo apt update
  # Install Python and pip
  sudo apt install python3 python3-pip -y
  # Upgrade pip
  sudo pip install --upgrade pip
  # Install TensorFlow
  sudo pip install tensorflow
  # Start TensorFlow
  python3
  import tensorflow as tf
  print(tf.version.VERSION)
EOF
}

  