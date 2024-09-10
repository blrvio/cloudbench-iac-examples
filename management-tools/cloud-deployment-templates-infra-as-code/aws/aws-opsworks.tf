
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an OpsWorks Stack
resource "aws_opsworks_stack" "main" {
  name             = "my-opsworks-stack"
  service_role_arn = "arn:aws:iam::123456789012:role/opsworks_service_role"
  # Optionally define custom settings for the stack
  custom_cookbooks_source {
    type = "git"
    url  = "https://github.com/example/cookbooks.git"
    #  revision = "master" # Optional: Specify a specific revision to checkout
  }
  # Optionally configure the default instance profile for the stack
  default_instance_profile_arn = "arn:aws:iam::123456789012:instance-profile/opsworks_instance_profile"
  default_os                   = "Amazon Linux 2"
  # Configure the VPC settings for the stack
  vpc_id = "vpc-1234567890abcdef0"
  # Optionally configure subnets
  # subnets = ["subnet-1234567890abcdef0", "subnet-1234567890abcdef1"]
  # Optionally configure security groups
  # security_group_ids = ["sg-1234567890abcdef0", "sg-1234567890abcdef1"]
  # Optionally configure custom Chef cookbooks
  # custom_cookbooks_source {
  #   type = "git"
  #   url  = "https://github.com/example/cookbooks.git"
  #   #  revision = "master" # Optional: Specify a specific revision to checkout
  # }
  # Configure the default SSH key
  # default_ssh_key_name = "my-ssh-key"
  # Optionally configure the default instance profile for the stack
  # default_instance_profile_arn = "arn:aws:iam::123456789012:instance-profile/opsworks_instance_profile"
}

# Create an OpsWorks Layer
resource "aws_opsworks_layer" "main" {
  name       = "my-opsworks-layer"
  stack_id   = aws_opsworks_stack.main.id
  shortname  = "my-layer"
  layer_type = "php-app"
  # Optionally define custom settings for the layer
  custom_security_group_ids = [aws_security_group.main.id]
}

# Create an OpsWorks Instance
resource "aws_opsworks_instance" "main" {
  layer_ids     = [aws_opsworks_layer.main.id]
  stack_id      = aws_opsworks_stack.main.id
  instance_type = "t2.micro"
  # Optionally configure the instance's hostname
  # hostname = "my-opsworks-instance"
  # Optionally configure the instance's root device type
  # root_device_type = "ebs"
  # Optionally configure the instance's EBS volume
  # ebs_volume {
  #   size = 100
  #   #  volume_type = "gp2"
  # }
  # Optionally configure the instance's AMI
  #  ami = "ami-08c40ec972c57421d"
  #  # Optional: Use a custom Chef cookbook for the instance
  #  custom_cookbooks_source {
  #    type = "git"
  #    url  = "https://github.com/example/cookbooks.git"
  #    #  revision = "master" # Optional: Specify a specific revision to checkout
  #  }
  # Optionally configure the instance's SSH key
  #  ssh_key_name = "my-ssh-key"
  # Optionally configure the instance's availability zone
  #  availability_zone = "us-east-1a"
  # Optionally configure the instance's subnet ID
  #  subnet_id = "subnet-1234567890abcdef0"
  #  # Optionally configure the instance's security groups
  #  security_group_ids = ["sg-1234567890abcdef0", "sg-1234567890abcdef1"]
  #  # Optionally configure the instance's root device type
  #  root_device_type = "ebs"
  # Optionally configure the instance's EBS volume
  #  ebs_volume {
  #    size = 100
  #    #  volume_type = "gp2"
  #  }
  # Optionally configure the instance's AMI
  #  ami = "ami-08c40ec972c57421d"
  #  # Optional: Use a custom Chef cookbook for the instance
  #  custom_cookbooks_source {
  #    type = "git"
  #    url  = "https://github.com/example/cookbooks.git"
  #    #  revision = "master" # Optional: Specify a specific revision to checkout
  #  }
  # Optionally configure the instance's SSH key
  #  ssh_key_name = "my-ssh-key"
  # Optionally configure the instance's availability zone
  #  availability_zone = "us-east-1a"
  # Optionally configure the instance's subnet ID
  #  subnet_id = "subnet-1234567890abcdef0"
  #  # Optionally configure the instance's security groups
  #  security_group_ids = ["sg-1234567890abcdef0", "sg-1234567890abcdef1"]
}

# Create a Security Group for the OpsWorks Instance
resource "aws_security_group" "main" {
  name = "sg-opsworks-instance"
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

  