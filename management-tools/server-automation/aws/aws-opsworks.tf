
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an OpsWorks Stack
resource "aws_opsworks_stack" "main" {
  name             = "my-opsworks-stack"
  service_role_arn = aws_iam_role.opsworks_service_role.arn
  # Optionally configure the stack
  default_instance_profile_arn = aws_iam_instance_profile.opsworks_instance_profile.arn
  default_os                   = "Amazon Linux 2"
  default_root_device_type     = "ebs"
  default_ssh_key_name         = "my-ssh-key"
  # Define the stack's VPC settings
  vpc_id = aws_vpc.main.id
  # Configure the stack's subnet settings
  subnet_ids = [aws_subnet.main.id]
  # Add custom cookbooks
  custom_cookbooks {
    # Configure the source for the custom cookbooks
    source {
      type     = "git"
      url      = "https://github.com/example/cookbook.git"
      revision = "master"
    }
    name = "my-custom-cookbook"
  }
  # Define the stack's layer configurations
  layer {
    name                    = "my-custom-layer"
    shortname               = "my-layer"
    type                    = "custom"
    auto_assign_elastic_ips = false
    auto_assign_public_ips  = false
    # Add custom recipes to the layer
    custom_recipes {
      name = "my-recipe"
      source {
        type = "s3"
        url  = "s3://my-bucket/my-recipe.rb"
      }
    }
  }
}

# Create an OpsWorks Instance
resource "aws_opsworks_instance" "main" {
  stack_id      = aws_opsworks_stack.main.id
  layer_ids     = [aws_opsworks_layer.main.id]
  instance_type = "t2.micro"
  # Configure the instance
  os = "Amazon Linux 2"
  # Associate an SSH key
  ssh_key_name = "my-ssh-key"
  # Define the instance's availability zone
  availability_zone = "us-east-1a"
  # Configure the instance's root volume
  root_device_type        = "ebs"
  root_device_volume_size = 20
  # Optionally define the instance's EBS volume configuration
  volume_configurations {
    device_name           = "/dev/sdh"
    delete_on_termination = true
    iops                  = 100
    size                  = 50
    volume_type           = "io1"
  }
  # Configure the instance's security group
  security_group_ids = [aws_security_group.main.id]
}

# Create an IAM role for the OpsWorks service
resource "aws_iam_role" "opsworks_service_role" {
  name               = "opsworks-service-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "opsworks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Create an IAM instance profile for the OpsWorks instances
resource "aws_iam_instance_profile" "opsworks_instance_profile" {
  name = "opsworks-instance-profile"
  role = aws_iam_role.opsworks_service_role.name
}

# Create a security group
resource "aws_security_group" "main" {
  name = "sg-opsworks"
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

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  # Configure the VPC's tags
  tags = {
    Name = "My VPC"
  }
}

# Create a subnet
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  # Configure the subnet's tags
  tags = {
    Name = "My Subnet"
  }
}

# Create a layer
resource "aws_opsworks_layer" "main" {
  stack_id                = aws_opsworks_stack.main.id
  name                    = "my-custom-layer"
  shortname               = "my-layer"
  type                    = "custom"
  auto_assign_elastic_ips = false
  auto_assign_public_ips  = false
  # Add custom recipes to the layer
  custom_recipes {
    name = "my-recipe"
    source {
      type = "s3"
      url  = "s3://my-bucket/my-recipe.rb"
    }
  }
}

  